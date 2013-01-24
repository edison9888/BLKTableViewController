//
//  BLKLoadMoreFooterView.h
//  BLKTableViewController
//
//  Created by Black on 12-11-27.
//  Copyright (c) 2012年 com.gyz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BLKLoadMoreStateNormal,
    BLKLoadMoreStateLoading,
    BLKLoadMoreStateNoMore
}BLKLoadMoreState;

@interface BLKLoadMoreFooterView : UIView

@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BLKLoadMoreState state;

@end
