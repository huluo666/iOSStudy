//
//  MusicListViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-19.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "MusicListViewController.h"
#import "AudioViewController.h"
#import "ZPAudioPlayerManager.h"

@interface MusicListViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_tableView;
    NSArray *_musicList;
}

- (void)initializeAudioPlayerDataSource;
- (void)initializeUserInterface;

@end

@implementation MusicListViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        
        self.title = @"音乐";
    }
    return self;
}

- (void)dealloc {
    
    [_tableView release];
    [_musicList release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeAudioPlayerDataSource];
    [self initializeUserInterface];
}

- (void)initializeAudioPlayerDataSource {
    
    _musicList = [@[@"Deemo Title Song - Website Version",
                    @"Release My Soul",
                    @"Rё.L",
                    @"Wings of piano"] retain];
    [[ZPAudioPlayerManager sharedZPAudioPlayerManager] addMusicList:_musicList];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_musicList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.textLabel.text = _musicList[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[ZPAudioPlayerManager sharedZPAudioPlayerManager] playAtIndex:indexPath.row];
    
    AudioViewController *audioVC = [[AudioViewController alloc] init];
    [self.navigationController pushViewController:audioVC animated:YES];
    [audioVC release];
}

@end
