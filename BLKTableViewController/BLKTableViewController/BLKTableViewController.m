//
//  BLKTableViewController.m
//  BLKTableViewController
//
//  Created by Black on 12-11-27.
//  Copyright (c) 2012年 com.gyz. All rights reserved.
//

#import "BLKTableViewController.h"

@interface BLKTableViewController ()

@end

@implementation BLKTableViewController

- (void)dealloc
{
    self.tableView = nil;
    self.dataSource = nil;
    [_refreshHeaderView release]; _refreshHeaderView = nil;
    [_loadMoreFooterView release]; _loadMoreFooterView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *errorMsg = [NSString stringWithFormat:@"You must setup your tableView before calling %@", NSStringFromSelector(_cmd)];
    NSAssert(_tableView, errorMsg);
    
    _dataSource = [[NSMutableArray alloc] init];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    if ([self useRefreshHeader]) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [_tableView addSubview:_refreshHeaderView];
    }
    
    if ([self useLoadMoreFooter]) {
        _loadMoreFooterView = [[BLKLoadMoreFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 44.0f)];
        _tableView.tableFooterView = _loadMoreFooterView;
    }
    
    canLoadMore = YES;
}

#pragma mark - ###Hooks

- (BOOL)useRefreshHeader
{
    return YES;
}

- (BOOL)useLoadMoreFooter
{
    return YES;
}

#pragma mark - ###Public methods

- (void)refreshTriggered
{
    canLoadMore = YES;
    _loadMoreFooterView.state = BLKLoadMoreStateLoading;
}

- (void)refreshCompleted
{
    [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:_tableView afterDelay:0.1];
}

- (void)loadMoreTriggered
{
    _loadMoreFooterView.state = BLKLoadMoreStateLoading;
}

- (void)loadMoreCompleted
{
    _loadMoreFooterView.state = canLoadMore ? BLKLoadMoreStateNormal : BLKLoadMoreStateNoMore;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if (!canLoadMore || _loadMoreFooterView.state == BLKLoadMoreStateLoading || scrollView.contentOffset.y < 0 || !(scrollView.contentOffset.y >= _tableView.contentSize.height - _tableView.bounds.size.height)) {
        return;
    }
    
    if (_refreshHeaderView.state != EGOOPullRefreshNormal) {
        return;
    }
    
    [self loadMoreTriggered];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self refreshTriggered];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return NO;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
