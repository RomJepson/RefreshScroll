//
//  RJPullDownCollectionViewController.m
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJPullDownCollectionViewController.h"

#import "RJCollectionViewCell.h"

#import "RJRefreshScrollHeaderView.h"
#import "RJRefreshScrollParameter.h"
#import "RJUIKit.h"

@interface RJPullDownCollectionViewController () <RJRefreshScrollHeaderDelegate> {
	RJRefreshScrollHeaderView *_refreshHeaderView;
	BOOL _reloading;
}

@end

@implementation RJPullDownCollectionViewController

- (void)dealloc {
    _refreshHeaderView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if (nil == _refreshHeaderView) {
        CGRect frame = self.collectionView.bounds;
        frame.origin.y = 0 - frame.size.height;
		RJRefreshScrollParameter *parameter = [[RJRefreshScrollParameter alloc] init];
        parameter.topDelta = 64.0f;
        parameter.bottomDelta = 49.0f;
        parameter.backgroundColor = RJColorRGB(226.0, 231.0, 237.0);
        parameter.textColor = RJColorRGB(87.0, 108.0, 137.0);
        parameter.activityIndicatorColor = parameter.textColor;
        parameter.arrowFileName = @"blue_arrow.png";
        parameter.pullPrompt = @"Pull down to refresh...";
        parameter.releasePrompt = @"Release to refresh...";
        parameter.loadingPrompt = @"Loading...";
        parameter.lastRefreshPrompt = @"Last Updated";
        parameter.lastRefreshKey = @"pullDownTableViewRefreshKey";
        parameter.amPrompt = @"AM";
        parameter.pmPrompt = @"PM";
        
		RJRefreshScrollHeaderView *view = [[RJRefreshScrollHeaderView alloc] initWithFrame:frame
                                                                                 parameter:parameter];
        [parameter release];
		view.delegate = self;
		[self.collectionView addSubview:view];
		_refreshHeaderView = view;
		[view release];
        [_refreshHeaderView refreshLastRefreshedDate];
	}

}

#pragma mark - UICollectionViewDataSource's methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.subtitle.text = [NSString stringWithFormat:@"%d,%d", indexPath.row, indexPath.section];
    NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageToLoad];
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView refreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView refreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - RJRefreshTableHeaderDelegate Methods
- (void)refreshScrollHeaderDidTriggerRefresh {
	[self reloadData];
}

- (BOOL)refreshScrollHeaderDataSourceIsLoading {
	return _reloading;
}

- (NSDate *)refreshScrollHeaderDataSourceLastUpdated {
	return [NSDate date];
}

#pragma mark - Private methods
- (void)reloadData {
	_reloading = YES;
    [self performSelector:@selector(didReloadData) withObject:nil afterDelay:3.0];
}

- (void)didReloadData {
	_reloading = NO;
	[_refreshHeaderView refreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
}

@end
