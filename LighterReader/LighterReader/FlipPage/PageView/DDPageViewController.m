//
//  DDPageViewController.m
//  「Demo」FlipPage
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPageViewController.h"

#define kRandomColor [UIColor colorWithRed:arc4random() % 128 / 255.0f green:arc4random() % 64 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.000]

#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)

static NSString *cellIdentifier = @"Cell";

@interface DDPageViewController ()

@end

@implementation DDPageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // calculate bounds and centers
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    // rowHeight
    CGFloat rowHeight = 44;
    CGFloat height = CGRectGetHeight(screenBounds);
    if (480 == height) {
        rowHeight = 83.2;
    } else if (568 == height) {
        rowHeight = 84;
    } else if (1024 == height) {
        rowHeight = 80;
    }
    
    self.tableView.rowHeight = rowHeight;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.bounces = NO;
    _dataSource = [[NSArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (_dataSource &&
        [_dataSource isKindOfClass:[NSArray class]]) {
        count = _dataSource.count;
    }
    return count;
    
//    NSInteger count = 0;
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGFloat height = CGRectGetHeight(screenBounds);
//    if (480 == height) {
//        count = 5;
//    } else if (568 == height) {
//        count = 6;
//    } else if (1024 == height) {
//        count = 12;
//    }
//    
//    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = kRandomColor;
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


@end
