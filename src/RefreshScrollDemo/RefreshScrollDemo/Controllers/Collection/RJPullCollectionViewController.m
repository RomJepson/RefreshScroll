//
//  RJPullViewController.m
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJPullCollectionViewController.h"

#import "RJCollectionViewCell.h"
#import "RJRefreshScrollFooterParameter.h"
#import "RJRefreshScrollFooterView.h"
#import "RJRefreshScrollHeaderParameter.h"
#import "RJRefreshScrollHeaderView.h"
#import "RJUIKit.h"

@interface RJPullCollectionViewController () <RJRefreshScrollHeaderDelegate, RJRefreshScrollFooterDelegate> {
	RJRefreshScrollHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    RJRefreshScrollFooterView *_refreshFooter;
    BOOL _isLoadingMore;
}

- (void)reloadData;
- (void)didReloadData;

- (void)loadMoreData;
- (void)didLoadMoreData;

@end

@implementation RJPullCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if (nil == _refreshHeaderView) {
        CGRect frame = self.collectionView.bounds;
        frame.origin.y = 0 - frame.size.height;
		RJRefreshScrollHeaderParameter *parameter = [[RJRefreshScrollHeaderParameter alloc] init];
        parameter.arrowFileName = @"blue_arrow.png";
        RJRefreshScrollHeaderView *view = [[RJRefreshScrollHeaderView alloc] initWithFrame:frame
                                                                                 parameter:parameter];
        [parameter release];
		view.delegate = self;
		[self.collectionView addSubview:view];
		_refreshHeaderView = view;
		[view release];
        [_refreshHeaderView refreshLastRefreshedDate];
	}
	
    [self performSelector:@selector(didLoadMoreData) withObject:nil afterDelay:.3];
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
	[_refreshHeaderView refreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
}

- (void)loadMoreData {
    _isLoadingMore = YES;
    [self performSelector:@selector(didLoadMoreData) withObject:nil afterDelay:3];
}

- (void)didLoadMoreData {
    _isLoadingMore = NO;
    
    CGRect frame = self.collectionView.frame;
    frame.origin.y = MAX(frame.size.height, self.collectionView.contentSize.height);
    if (nil != _refreshFooter) {
        _refreshFooter.frame = frame;
    } else {
        RJRefreshScrollFooterParameter *parameter = [[RJRefreshScrollFooterParameter alloc] init];
        parameter.arrowFileName = @"blue_arrow.png";
        RJRefreshScrollFooterView *refreshFooter = [[RJRefreshScrollFooterView alloc] initWithFrame:frame parameter:parameter];
        [parameter release];
        
        [self.collectionView addSubview:refreshFooter];
        _refreshFooter = refreshFooter;
        [refreshFooter release];
        _refreshFooter.delegate = self;
        [_refreshFooter refreshLastRefreshedDate];
    }
    [_refreshFooter refreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
}

@end
