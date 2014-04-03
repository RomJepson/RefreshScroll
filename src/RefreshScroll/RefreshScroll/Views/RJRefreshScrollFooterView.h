//
//  RJRefreshTableHeaderView.h
//  RefreshScroll
//
//  Created by Youyi Zhang on 13-9-30.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#include "RJRefreshState.h"

@class RJRefreshScrollFooterParameter;

@protocol RJRefreshScrollFooterDelegate;

/**
 * Pull up to refresh scroll view, such as UITableView or UICollectionView(PSTCollectionView)
 */
@interface RJRefreshScrollFooterView : UIView

/**
 * The delegate of the RJRefreshScrollFooterView
 */
@property(nonatomic, assign) id<RJRefreshScrollFooterDelegate> delegate;

/**
 * Initialize
 * @param frame, The frame of the RJRefreshScrollFooterView
 * @param parameter, Other initial parameters.
 * @return, self
 */
- (id)initWithFrame:(CGRect)frame parameter:(RJRefreshScrollFooterParameter *)parameter;

/**
 * Update the last refreshed date, please send "initWithFrame:parameter:" message.
 */
- (void)refreshLastRefreshedDate;
/**
 * Please send this message when scrolling content view.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
/**
 * Please send this messsage when finished scrolling.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
/**
 * Please send this message when finished loading.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

/**
 * The delegate of the RJRefreshScrollFooterView
 */
@protocol RJRefreshScrollFooterDelegate

/**
 * The "RJRefreshScrollFooterView" sends this message after began to refresh.
 */
- (void)refreshScrollFooterDidTriggerRefresh;
/**
 * Whether the scroll view is loading data or not.
 * @return, whether the scroll view is loading data or not.
 */
- (BOOL)refreshScrollFooterDataSourceIsLoading;

@optional
/**
 * Get the data source update date.
 * @return, The data source update date.
 */
- (NSDate *)refreshScrollFooterDataSourceLastRefresh;

@end