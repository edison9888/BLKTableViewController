//
//  BLKTableViewController.h
//  BLKTableViewController
//
//  Created by Black on 12-11-27.
//  Copyright (c) 2012年 com.gyz. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "EGORefreshTableHeaderView.h"
#import "BLKLoadMoreFooterView.h"

@interface BLKTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    @private
    EGORefreshTableHeaderView *_refreshHeaderView;
    BLKLoadMoreFooterView *_loadMoreFooterView;
    
    @protected
    IBOutlet UITableView *_tableView;
    NSMutableArray *_dataSource;
    //  defaults to YES, manage it yourself
    BOOL canLoadMore;
}

//  !!! you MUST setup your tableView first before calling [super viewDidLoad]
//  !!! tableView's dataSource and delegate are auto set to self
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, readonly) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, readonly) BLKLoadMoreFooterView *loadMoreFooterView;

//  a hook to determine whether to use EGORefreshTableHeaderView
//  overide this method and return NO to disable pull-down refresh feature, defaults to YES
- (BOOL)useRefreshHeader;
//  a hook to determine whether to use BLKLoadMoreFooterView
//  overide this method and return NO to disable load more feature, defaults to YES
- (BOOL)useLoadMoreFooter;

//  pull-down refresh methods
- (void)refreshTriggered;
//  always call this method when you finished refresh
- (void)refreshCompleted;

//  load more methods
//  always call these super methods to update _loadMoreFooterView's state
- (void)loadMoreTriggered;
//  always call this method when you finished load more
- (void)loadMoreCompleted;

@end
