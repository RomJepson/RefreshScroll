//
//  RJRefreshTableHeaderView.m
//  RefreshScroll
//
//  Created by Youyi Zhang on 13-9-30.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJRefreshScrollFooterView.h"

#import <QuartzCore/QuartzCore.h>

#import "RJRefreshScrollFooterParameter.h"
#import "RJSystem.h"
#import "RJUIKit.h"

#define REFRESH_FOOTER_HEIGHT 65.0f

#define FLIP_ANIMATION_DURATION 0.18f

@interface RJRefreshScrollFooterView () {
	id _delegate;
	RJRefreshState _state;
    
	UILabel *_lblStatus;
    UILabel *_lblLastRefresh;
	CALayer *_calArrowImage;
	UIActivityIndicatorView *_aivActivityIndicator;
}

@property(nonatomic, retain) RJRefreshScrollFooterParameter *parameter;

- (void)setState:(RJRefreshState)state;
- (BOOL)needRefreshScrollView:(UIScrollView *)scrollView;
- (void)setScrollView:(UIScrollView *)scrollView hideFooter:(BOOL)hideFooter;

@end

@implementation RJRefreshScrollFooterView

@synthesize delegate = _delegate;

#pragma mark - Memory Management
- (id)initWithFrame:(CGRect)frame parameter:(RJRefreshScrollFooterParameter *)parameter {
    if (self = [super initWithFrame:frame]) {
        self.parameter = parameter;
        if (nil == self.parameter) {
            _parameter = [[RJRefreshScrollFooterParameter alloc] init];
        }
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = self.parameter.backgroundColor;
        
        //Initialize status label.
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = self.parameter.textColor;
        label.backgroundColor = [UIColor clearColor];
#if __IPHONE_6_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        label.textAlignment = NSTextAlignmentCenter;
#else
        label.textAlignment = UITextAlignmentCenter;
#endif
        [self addSubview:label];
        _lblStatus = label;
        [label release];
        
        //Initialize last update label.
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 30.0f, frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = self.parameter.textColor;
        label.backgroundColor = [UIColor clearColor];
#if __IPHONE_6_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        label.textAlignment = NSTextAlignmentCenter;
#else
        label.textAlignment = UITextAlignmentCenter;
#endif
        [self addSubview:label];
        _lblLastRefresh = label;
        [label release];
        
        //Initialize arrow image layer.
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, 10.f, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:parameter.arrowFileName].CGImage;
        [self.layer addSublayer:layer];
        _calArrowImage = layer;
        
        //Initialize activity indicator.
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(25.0f, 18.0f, 20.0f, 20.0f);
        activityIndicator.color = self.parameter.activityIndicatorColor;
        [self addSubview:activityIndicator];
        _aivActivityIndicator = activityIndicator;
        [activityIndicator release];
        
        [self setState:RJRefreshNormal];
    }
    return self;
}

- (void)dealloc {
    self.parameter = nil;
    
	_delegate = nil;
	_aivActivityIndicator = nil;
	_lblStatus = nil;
	_calArrowImage = nil;
	_lblLastRefresh = nil;
    [super dealloc];
}

#pragma mark - Public Methods
- (void)refreshLastRefreshedDate {
	if ([_delegate respondsToSelector:@selector(refreshScrollFooterDataSourceLastRefresh)]) {
        //Format date string
		NSDate *date = [_delegate refreshScrollFooterDataSourceLastRefresh];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:self.parameter.amPrompt];
        [formatter setPMSymbol:self.parameter.pmPrompt];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
        _lblLastRefresh.text = [NSString stringWithFormat:@"%@: %@", self.parameter.lastRefreshPrompt, [formatter stringFromDate:date]];
        
        //Store update info to NSUserDefaults.
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_lblLastRefresh.text forKey:self.parameter.lastRefreshKey];
        [userDefault synchronize];
        [formatter release];
        
	} else {
		_lblLastRefresh.text = nil;
	}
}

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (RJRefreshLoading == _state) {
        [self setScrollView:scrollView hideFooter:NO];
    } else if (scrollView.isDragging) {
        BOOL loading = [_delegate refreshScrollFooterDataSourceIsLoading];
        if (RJRefreshPulling == _state && ![self needRefreshScrollView:scrollView] && !loading) {
            [self setState:RJRefreshNormal];
        } else if (RJRefreshNormal == _state && [self needRefreshScrollView:scrollView] && !loading) {
            [self setState:RJRefreshPulling];
        }
        
        if (RJSYS_VER_LESS_THAN_7) {
            if (0 != scrollView.contentInset.bottom) {
                [self setScrollView:scrollView hideFooter:YES];
            }
        } else {
            if (self.parameter.bottomDelta != scrollView.contentInset.bottom) {
                [self setScrollView:scrollView hideFooter:YES];
            }
        }
    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    BOOL loading = [_delegate refreshScrollFooterDataSourceIsLoading];
    if ([self needRefreshScrollView:scrollView] && !loading) {
        [_delegate refreshScrollFooterDidTriggerRefresh];
        [self setState:RJRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [self setScrollView:scrollView hideFooter:NO];
        [UIView commitAnimations];
    }
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [self setState:RJRefreshNormal];
    [self setScrollView:scrollView hideFooter:YES];
    [UIView commitAnimations];
}

#pragma mark - Private methods
- (void)setState:(RJRefreshState)state {
	switch (state) {
		case RJRefreshPulling:
            _lblStatus.text = self.parameter.releasePrompt;
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _calArrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
			break;
		case RJRefreshNormal:
            if (RJRefreshPulling == _state) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _calArrowImage.transform = CATransform3DMakeRotation(RJANGLE_TO_RADIAN(180.0f), 0.0f, 0.0f, 1.0f);
                [CATransaction commit];
            }
            _lblStatus.text = self.parameter.pullPrompt;
            [_aivActivityIndicator stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _calArrowImage.hidden = NO;
            _calArrowImage.transform = CATransform3DMakeRotation(RJANGLE_TO_RADIAN(180.0f), 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            [self refreshLastRefreshedDate];
			break;
		case RJRefreshLoading:
            _lblStatus.text = self.parameter.loadingPrompt;
            [_aivActivityIndicator startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _calArrowImage.hidden = YES;
            [CATransaction commit];
			break;
	}
	
	_state = state;
}

- (BOOL)needRefreshScrollView:(UIScrollView *)scrollView {
    return RJSYS_VER_LESS_THAN_7 ?
        REFRESH_FOOTER_HEIGHT + scrollView.contentSize.height < scrollView.contentOffset.y + scrollView.frame.size.height :
        REFRESH_FOOTER_HEIGHT + self.parameter.bottomDelta + scrollView.contentSize.height < scrollView.contentOffset.y + scrollView.frame.size.height;
}

- (void)setScrollView:(UIScrollView *)scrollView hideFooter:(BOOL)hideFooter {
    UIEdgeInsets contentInset = scrollView.contentInset;
    if (hideFooter) {
        contentInset.bottom = RJSYS_VER_LESS_THAN_7 ? 0 : self.parameter.bottomDelta;
    } else {
        contentInset.bottom = RJSYS_VER_LESS_THAN_7 ? REFRESH_FOOTER_HEIGHT : REFRESH_FOOTER_HEIGHT + self.parameter.bottomDelta;
    }
    scrollView.contentInset = contentInset;
}

@end
