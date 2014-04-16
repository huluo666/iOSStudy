//
//  DDListViewController.m
//  「Demo」StoryBoard
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDListViewController.h"

@interface DDListViewController ()

@property (strong, nonatomic) NSMutableArray *listArray;
@property (copy, nonatomic) NSDictionary *editedSelection;

@end

@implementation DDListViewController

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

    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:
                             @"Horse", @"Sheep", @"Pig", @"Dog",
                             @"Cat", @"Chicken", @"Duck", @"Goose",
                             @"Tree", @"Flower", @"Grass", @"Fence",
                             @"House", @"Table", @"Chair", @"Book",
                             @"Swing" ,nil];
    self.listArray = array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *identifier = nil;
    if (row%2 == 0) {
        identifier = @"GreenIdentifier";
    }else
        identifier = @"RedIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    cellLabel.text = [_listArray objectAtIndex:row];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获取目的ViewController
    UIViewController *destination = [segue destinationViewController];
    if ([destination respondsToSelector:@selector(setPreViewController:)]) {
        //将自身传递给目的ViewController
        [destination setValue:self forKey:@"preViewController"];
    }
    if ([destination respondsToSelector:@selector(setSelection:)]) {
        //目的ViewController中的selection属性存储的就是需要编辑的内容及其在表格中的位置
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        id object = [self.listArray objectAtIndex:indexPath.row];
        NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                   indexPath, @"indexPath",
                                   object, @"object",
                                   nil];
        [destination setValue:selection forKey:@"selection"];
    }
}

- (void)setEditedSelection:(NSDictionary *)dict {
    if (![dict isEqual:_editedSelection]) {
        _editedSelection = dict;
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        id newValue = [dict objectForKey:@"object"];
        [_listArray replaceObjectAtIndex:indexPath.row withObject:newValue];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
