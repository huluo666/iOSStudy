//
//  RootViewController.m
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    _listArray = [@[@"《岳阳楼记》是一篇为重修岳阳楼写的记。由北宋文学家范仲淹应好友巴陵郡守滕子京之请，于北宋庆历六年（1046年）九月十五日所作。其中的诗句“先天下之忧而忧，后天下之乐而乐”、“不以物喜，不以己悲”是较为出名和引用较多的句子。《岳阳楼记》能够成为传世名篇并非因为其对岳阳楼风景的描述，而是范仲淹借《岳阳楼记》一文抒发先忧后乐、忧国忧民的情怀", @"仁宗庆历四年春天，滕子京被降职到巴陵郡做太守。到了第二年，政事顺利，百姓和乐，各种荒废的事业都兴办起来。于是重新修建岳阳楼，扩增它旧有的规模，在岳阳楼上刻上唐代名家和当代人的诗赋。嘱托我写一篇文章来记述这件事", @"庆历四年春，滕（téng）子京谪（zhé）守巴陵郡。越明年，政通人和，百废具兴，乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属（zhǔ）予（yú）作文以记之", @"予观夫（fú）巴陵胜状，在洞庭一湖", @"至若春和景明，波澜不惊，上下天光", @"岸芷（zhǐ） 汀（tīng）兰", @"若夫（fú）淫（yín）雨霏霏，连月不开；阴风怒号，浊浪排空。日星隐曜（yào），山岳潜形。商旅不行，樯（qiáng）倾楫（jí）摧。薄（bó）暮冥冥（míng），虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥（jī），满目萧然，感极而悲者矣。", @"岸芷（zhǐ） 汀（tīng）兰", @"若夫（fú）淫（yín）雨霏霏，连月不开；阴风怒号，浊浪排空。日星隐曜（yào），山岳潜形。商旅不行，樯（qiáng）倾楫（jí）摧。薄（bó）暮冥冥（míng），虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥（jī），满目萧然，感极而悲者矣。", @"至若春和景明，波澜不惊，上下天光，一碧万顷（qǐng）。沙鸥翔集，锦鳞游泳；岸芷（zhǐ） 汀（tīng）兰，郁郁青青。而或长烟一空，皓月千里，浮光跃金，静影沉璧。渔歌互答，此乐何极！登斯楼也，则有心旷神怡，宠辱偕（xié）忘，把酒临风，其喜洋洋者矣。"] retain];
    
    _tableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self; // 设置数据源
    _tableView.delegate   = self; // 设置委托
    [self.view addSubview:_tableView];
    
    _index = -1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_listArray count];
} // section 中包含row的数量

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义一个静态标识符
    static NSString *cellIdentifier = @"cell";
    // 检查是否限制单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 创建单元格
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    // 给cell内容赋值
    NSString *fontName = _listArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = fontName;
    
    return cell;
    
} // 创建单元格

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
} // 表视图当中存在secion的个数，默认是1个
 */

#pragma mark - UITableViewDelegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  NSIndexPath -> max row  取消上一次选中
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
    UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
    lastCell.accessoryType = UITableViewCellAccessoryNone;
    // 用户选中了新的一行
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _index = indexPath.row;

    [_tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath : %d", indexPath.row);
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // wrong  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = [_listArray objectAtIndex:indexPath.row];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, 1000)];
    
    return size.height+20;
}

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}

@end
