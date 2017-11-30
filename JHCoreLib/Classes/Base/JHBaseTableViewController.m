//
//  JHBaseTableViewController.m
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "MJRefresh.h"

#define JHUIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define JHDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface JHBaseTableViewController ()

@end

@implementation JHBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:[self tableViewStyle]];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:_tableView];
    
    _rows = [NSMutableArray array];

    UIView *topView = [self topView];
    if(topView){
        topView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:topView];

        NSDictionary *viewDict = @{@"topView":topView,@"tableView":_tableView};
        NSArray *hContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topView]-0-|" options:0 metrics:nil views:viewDict];
        NSString *vContraintsFormat = [NSString stringWithFormat:@"V:|-0-[topView(%@)]-0-[tableView]",@(CGRectGetHeight(topView.bounds))];
        NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:vContraintsFormat options:0 metrics:nil views:viewDict];
        [self.view addConstraints:hContraints];
        [self.view addConstraints:vContraints];
    }
    
    UIView *bottomView = [self bottomView];
    if(bottomView){
        bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:bottomView];
        
        NSDictionary *viewDict = @{@"bottomView":bottomView,@"tableView":_tableView};
        NSArray *hContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomView]-0-|" options:0 metrics:nil views:viewDict];
        CGFloat bottomInset = 0;
        if(JHDevice_Is_iPhoneX){//让出iphoneX底部的安全距离
            bottomInset = 34;
        }
        NSString *vContraintsFormat = [NSString stringWithFormat:@"V:[tableView]-0-[bottomView(%@)]-%f-|",@(CGRectGetHeight(bottomView.bounds)),bottomInset];
        NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:vContraintsFormat options:0 metrics:nil views:viewDict];
        [self.view addConstraints:hContraints];
        [self.view addConstraints:vContraints];
    }
    
    NSDictionary *viewDict = @{@"tableView":_tableView};
    NSArray *hContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:viewDict];
    NSString *vContraintsFormat = @"V:|-0-[tableView]-0-|";
    if(topView && !bottomView){
        viewDict = @{@"topView":topView,@"tableView":_tableView};
        vContraintsFormat = @"V:[topView]-0-[tableView]-0-|";
    }else if (!topView && bottomView){
        viewDict = @{@"bottomView":bottomView,@"tableView":_tableView};
        vContraintsFormat = @"V:|-0-[tableView]-0-[bottomView]";
    }else if (topView && bottomView){
        viewDict = @{@"topView":topView,@"bottomView":bottomView,@"tableView":_tableView};
        vContraintsFormat = @"V:[topView]-0-[tableView]-0-[bottomView]";
    }
    NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:vContraintsFormat options:0 metrics:nil views:viewDict];
    [self.view addConstraints:hContraints];
    [self.view addConstraints:vContraints];
    
    [self configRefreshUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (UIView *)topView {
    return nil;
}

- (UIView *)bottomView {
    return nil;
}

#pragma mark --UITableViewDataSource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -- 刷新的一些方法

- (void)configRefreshUI {
    __weak typeof(self) weakSelf = self;

    if ([self shouldShowRefresh]) {
        MJRefreshStateHeader *refreshHeader = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf requestRefresh];
        }];
        refreshHeader.lastUpdatedTimeLabel.textColor = JHUIColorFromRGB(0x999999);
        refreshHeader.stateLabel.textColor = JHUIColorFromRGB(0x999999);
        _tableView.mj_header = refreshHeader;
    }
    
    if ([self shouldShowGetMore]) {
        MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf requestGetMore];
        }];
        footer.stateLabel.textColor = JHUIColorFromRGB(0x999999);
        footer.stateLabel.font = [UIFont systemFontOfSize:11];
        [footer setTitle:@"暂无更多" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        footer.automaticallyHidden = YES;
        _tableView.mj_footer = footer;
    }
}

- (BOOL)shouldShowRefresh {
    return YES;
}

- (BOOL)shouldShowGetMore {
    return YES;
}

- (void)requestRefresh {
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}

- (void)requestGetMore {
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}

@end

@implementation JHBaseTableViewController (JHRefresh)

- (void)finishRequest {
    if([self.tableView.mj_header isRefreshing]){
        [self.tableView.mj_header endRefreshing];
    }
    if([self.tableView.mj_footer isRefreshing]){
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)toTriggerRequestRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)toTriggerRequestGetMore {
    [self.tableView.mj_footer beginRefreshing];
}

@end
