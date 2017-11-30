//
//  JHBaseViewController.h
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/3.
//  Copyright © 2016年 glm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHBaseViewControllerDatasource <NSObject>

@optional
/**
 *  实现此协议方法为navigationBar添加leftBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)leftItemViews;
/**
 *  实现此协议方法为navigationBar添加rightBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)rightItemViews;
/**
 *  实现此协议方法决定是否要隐藏navigationBar
 *
 *  @return 基类中实现了此方法默认返回NO
 */
- (BOOL)shouldHideNavigationBar;
/**
 *  实现此协议方法决定是否显示返回按钮
 *
 *  @return 基类中实现了此方法默认返回YES
 */
- (BOOL)shouldShowBackItem;

@end

@protocol JHBaseViewControllerDelegate <NSObject>

@optional
/**
 *  已经默认实现了此协议方法，只有需要获取返回事件的时候才重写此协议方法，但必须调用父类的方法
 *
 *  @param button 点击返回的按钮
 */
- (void)backItemAction:(UIButton*)button;
/**
 *  双击当前UITabBarItem的事件
 */
- (void)doubleTapTabBarItemAction;

@end

@interface JHBaseViewController : UIViewController<JHBaseViewControllerDatasource, JHBaseViewControllerDelegate>

@property (nonatomic, weak) id<JHBaseViewControllerDatasource>datasource;//也可以指定别的代理实现所需的功能，此代理实现的功能优先使用
@property (nonatomic, weak) id<JHBaseViewControllerDelegate>delegate;//同上

@end



