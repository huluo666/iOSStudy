//
//  RootViewController.m
//  「UI」UITableView(Cell行高自适应)
//
//  Created by 萧川 on 14-2-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSArray *dataSource;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_dataSource release];
    [super dealloc];
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _dataSource = [@[@"《岳阳楼记》是一篇为重修岳阳楼写的记。由北宋文学家范仲淹应好友巴陵郡守滕子京之请，于北宋庆历六年（1046年）九月十五日所作。其中的诗句“先天下之忧而忧，后天下之乐而乐”、“不以物喜，不以己悲”是较为出名和引用较多的句子。《岳阳楼记》能够成为传世名篇并非因为其对岳阳楼风景的描述，而是范仲淹借《岳阳楼记》一文抒发先忧后乐、忧国忧民的情怀", @"仁宗庆历四年春天，滕子京被降职到巴陵郡做太守。到了第二年，政事顺利，百姓和乐，各种荒废的事业都兴办起来。于是重新修建岳阳楼，扩增它旧有的规模，在岳阳楼上刻上唐代名家和当代人的诗赋。嘱托我写一篇文章来记述这件事", @"庆历四年春，滕（téng）子京谪（zhé）守巴陵郡。越明年，政通人和，百废具兴，乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属（zhǔ）予（yú）作文以记之", @"予观夫（fú）巴陵胜状，在洞庭一湖", @"至若春和景明，波澜不惊，上下天光", @"岸芷（zhǐ） 汀（tīng）兰", @"若夫（fú）淫（yín）雨霏霏，连月不开；阴风怒号，浊浪排空。日星隐曜（yào），山岳潜形。商旅不行，樯（qiáng）倾楫（jí）摧。薄（bó）暮冥冥（míng），虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥（jī），满目萧然，感极而悲者矣。", @"岸芷（zhǐ） 汀（tīng）兰", @"若夫（fú）淫（yín）雨霏霏，连月不开；阴风怒号，浊浪排空。日星隐曜（yào），山岳潜形。商旅不行，樯（qiáng）倾楫（jí）摧。薄（bó）暮冥冥（míng），虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥（jī），满目萧然，感极而悲者矣。", @"至若春和景明，波澜不惊，上下天光，一碧万顷（qǐng）。沙鸥翔集，锦鳞游泳；岸芷（zhǐ） 汀（tīng）兰，郁郁青青。而或长烟一空，皓月千里，浮光跃金，静影沉璧。渔歌互答，此乐何极！登斯楼也，则有心旷神怡，宠辱偕（xié）忘，把酒临风，其喜洋洋者矣。"] retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark 不能使用tableView 来获取cell,然后获取cell.textLabel.txt来计算文本所占空间大小
    CGSize size = [self sizeWithString:_dataSource[indexPath.row] font:[UIFont systemFontOfSize:12.0f] constraintSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    return size.height + 20;
}

#pragma mark - 私有方法

// 根据文本内容获取Rect的size
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options: NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading |
                   NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size;
}

@end
