//
//  ViewController.m
//  BLKTableViewController
//
//  Created by Black on 12-11-27.
//  Copyright (c) 2012年 com.gyz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch data

- (void)fetchData
{
    int count = [_dataSource count];
    for (int i = count; i < count+10; i++) {
        NSString *item = [NSString stringWithFormat:@"item %d", i];
        [_dataSource addObject:item];
    }
    
    [self performSelector:@selector(receivedData) withObject:nil afterDelay:1.0];
}

- (void)receivedData
{
    [_tableView reloadData];
    
    if (_dataSource.count > 40) {
        canLoadMore = NO;
    }
    
    [self refreshCompleted];
    [self loadMoreCompleted];
}

#pragma mark - Refresh

- (void)refreshTriggered
{
    [super refreshTriggered];
    
    [_dataSource removeAllObjects];
    [self fetchData];
}

#pragma mark - Load more

- (void)loadMoreTriggered
{
    [super loadMoreTriggered];
    
    [self fetchData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

@end
