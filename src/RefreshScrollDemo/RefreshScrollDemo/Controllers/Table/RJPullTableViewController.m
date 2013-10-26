//
//  RJPullTableViewController.m
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-12.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJPullTableViewController.h"

#import "RJRefreshScrollFooterView.h"
#import "RJRefreshScrollHeaderView.h"
#import "RJRefreshScrollParameter.h"
#import "RJUIKit.h"

@interface RJPullTableViewController () <RJRefreshScrollHeaderDelegate, RJRefreshScrollFooterDelegate> {
	RJRefreshScrollHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    RJRefreshScrollFooterView *_refreshFooter;
    BOOL _isLoadingMore;
}

@property(nonatomic, retain) NSMutableArray *items;

- (void)reloadData;
- (void)didReloadData;

- (void)loadMoreData;
- (void)didLoadMoreData;

@end

@implementation RJPullTableViewController

#pragma mark - Memory Management
- (void)dealloc {
    _refreshHeaderView = nil;
    _refreshFooter = nil;
    self.items = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (nil == _refreshHeaderView) {
        CGRect frame = self.tableView.bounds;
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
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
        [_refreshHeaderView refreshLastRefreshedDate];
	}
	
    _items = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        NSString *item = [[NSString alloc] initWithFormat:@"item: %d", i];
        [self.items addObject:item];
        [item release];
    }
    
    [self performSelector:@selector(didLoadMoreData) withObject:nil afterDelay:.3];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView refreshScrollViewDidScroll:scrollView];
    [_refreshFooter refreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView refreshScrollViewDidEndDragging:scrollView];
    [_refreshFooter refreshScrollViewDidEndDragging:scrollView];
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

#pragma mark - RJRefreshTableFooterDelegate methods
- (void)refreshScrollFooterDidTriggerRefresh {
    [self loadMoreData];
}

- (BOOL)refreshScrollFooterDataSourceIsLoading {
    return _isLoadingMore;
}

- (NSDate *)refreshScrollFooterDataSourceLastRefresh {
    return [NSDate date];
}

#pragma mark - Private methods
- (void)reloadData {
	_reloading = YES;
    [self performSelector:@selector(didReloadData) withObject:nil afterDelay:3.0];
}

- (void)didReloadData {
	_reloading = NO;
	[_refreshHeaderView refreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)loadMoreData {
    _isLoadingMore = YES;
    [self performSelector:@selector(didLoadMoreData) withObject:nil afterDelay:3];
}

- (void)didLoadMoreData {
    _isLoadingMore = NO;
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = MAX(frame.size.height, self.tableView.contentSize.height);
    if (nil != _refreshFooter) {
        _refreshFooter.frame = frame;
    } else {
        RJRefreshScrollParameter *parameter = [[RJRefreshScrollParameter alloc] init];
        parameter.topDelta = 64.0f;
        parameter.bottomDelta = 49.0f;
        parameter.backgroundColor = RJColorRGB(226.0, 231.0, 237.0);
        parameter.textColor = RJColorRGB(87.0, 108.0, 137.0);
        parameter.activityIndicatorColor = parameter.textColor;
        parameter.arrowFileName = @"blue_arrow.png";
        parameter.pullPrompt = @"Pull up to load more...";
        parameter.releasePrompt = @"Release to load more...";
        parameter.loadingPrompt = @"Loading...";
        parameter.lastRefreshPrompt = @"Last Updated";
        parameter.lastRefreshKey = @"pullUpTableViewRefreshKey";
        parameter.amPrompt = @"AM";
        parameter.pmPrompt = @"PM";
        
        RJRefreshScrollFooterView *refreshFooter = [[RJRefreshScrollFooterView alloc] initWithFrame:frame parameter:parameter];
        [parameter release];
        
        [self.tableView addSubview:refreshFooter];
        _refreshFooter = refreshFooter;
        [refreshFooter release];
        _refreshFooter.delegate = self;
        [_refreshFooter refreshLastRefreshedDate];
    }
    [_refreshFooter refreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

@end
