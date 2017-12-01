//
//  JHBaseTableViewController.h
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseTableViewController : JHBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) NSMutableArray *rows;//数据源

- (UITableViewStyle)tableViewStyle;//默认返回UITableViewStylePlain
/**
 *  如果想定制顶部固定的view，子类需要重写此方法
 *
 *  @return 默认为nil
 */
- (UIView *)topView;
/**
 *  如果想定制底部固定的view，子类需要重写此方法
 *
 *  @return 默认为nil
 */
- (UIView *)bottomView;

/**
 *  如果不想要下拉刷新，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
- (BOOL)shouldShowRefresh;
/**
 *  如果不想要上拉加载更多，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
- (BOOL)shouldShowGetMore;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestRefresh;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestGetMore;
/**
 *  配置列表header和footer刷新数据的UI，已经有默认配置
 */
- (void)configRefreshUI;

@end

@interface JHBaseTableViewController (JHRefresh)

/**
 触发刷新刷新动作
 */
- (void)toTriggerRequestRefresh;

/**
 触发上拉加载动作
 */
- (void)toTriggerRequestGetMore;

/**
 请求完成，不管成功或者失败必须手动调用此方法结束刷新动画
 */
- (void)finishRequest;

@end
