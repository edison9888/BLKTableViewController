//
//  BLKLoadMoreFooterView.m
//  BLKTableViewController
//
//  Created by Black on 12-11-27.
//  Copyright (c) 2012年 com.gyz. All rights reserved.
//

#import "BLKLoadMoreFooterView.h"

@implementation BLKLoadMoreFooterView

- (void)dealloc
{
    self.infoLabel = nil;
    self.activityIndicator = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)] autorelease];
        _infoLabel.textColor = [UIColor lightGrayColor];
        _infoLabel.textAlignment = UITextAlignmentCenter;
        _infoLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_infoLabel];
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.center = CGPointMake(self.center.x - 46.0f, self.center.y);
        [self addSubview:_activityIndicator];
        
        self.state = BLKLoadMoreStateLoading;
    }
    return self;
}

- (void)setState:(BLKLoadMoreState)state
{
    _state = state;
    
    switch (state) {
        case BLKLoadMoreStateNormal:
            [_infoLabel setText:@"上拉加载更多"];
            [_activityIndicator stopAnimating];
            break;
        case BLKLoadMoreStateLoading:
            [_infoLabel setText:@"加载中..."];
            [_activityIndicator startAnimating];
            break;
        case BLKLoadMoreStateNoMore:
            [_infoLabel setText:@"已加载完全部"];
            [_activityIndicator stopAnimating];
            break;
            
        default:
            break;
    }
}

@end
