//
//  DDFeedsGroupViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFeedsGroupViewController.h"
#import "DDTitleOnlyCell.h"
#import "DDListCell.h"
#import "DDListCell.h"

static NSString *cellIdentifier = @"Cell";

@interface DDFeedsGroupViewController ()

@end

@implementation DDFeedsGroupViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = screenBounds;
        self.tableView.frame = screenBounds;
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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[DDListCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:cellIdentifier];
        
    }
    cell.leftImage = [UIImage imageNamed:@"mobile-action-magazine"];
    
//    if (!cell) {
//        cell = [[DDTitleOnlyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    }
    
//    self.celltype = DDCellTypeList;
//    if (!cell) {
//        switch (self.celltype) {
//            case DDCellTypeTitleOnly: {
//                
//            }
//                break;
//            case DDCellTypeList: {
//                cell = [[DDListCell alloc]
//                        initWithStyle:UITableViewCellStyleDefault
//                        reuseIdentifier:cellIdentifier];
//            }
//                break;
//            case DDCellTypeMagazine: {
//                
//            }
//                break;
//            case DDCellTypeCards: {
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
    cell.titleLabel.text = @"Override to support .onditional editing of the table view.Return NO if you do not want the specified item ";
    cell.reviewLabel.text = @"Override to support conditional editing of the table view.Return NO if you do not want the specified item to be editable.";
    cell.hintLabel.text = @"200k Manshable / 5h";
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
