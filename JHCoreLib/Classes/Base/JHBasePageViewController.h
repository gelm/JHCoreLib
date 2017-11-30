//
//  JHBasePageViewController.h
//  JHModuleDemo
//
//  Created by 各连明 on 2016/12/12.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseViewController.h"

@protocol JHBasePageViewControllerDelegate <NSObject>

@optional
/**
 *  实现此协议方法，可以获得滑动翻页完成后当前viewController的index和前一个viewController的index，以便于后续的操作
 *
 *  @param index    动画结束后当前viewController的index
 *  @param previousIndex 动画结束后前一个viewController的index
 */
- (void)pageViewScrollToIndex:(NSInteger)index previousIndex:(NSInteger)previousIndex;

@end

@interface JHBasePageViewController : JHBaseViewController<JHBasePageViewControllerDelegate>

@property (nonatomic, strong, readonly) UIPageViewController *pageViewController;
@property (nonatomic, strong, readwrite) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, weak, readonly) UIScrollView *pageScrollView;
/**
 *  重写此方法可定义第一次显示的viewController，默认显示第一个
 *
 *  @return 需要显示viewController的index
 */
- (NSInteger)defaultIndex;
/**
 *  重写此方法决定是否可滑动翻页，默认可滑动YES
 *
 *  @return YES
 */
- (BOOL)pageScrollEnabled;
/**
 *  重写此方法可返回定制的分段控制器，默认为nil
 *
 *  @return 想要的分段控制器
 */
- (UIView *)customSegmentedControl;
/**
 *  需要时可以设置想要显示的viewController，不要重写，直接使用
 *
 *  @param index    显示viewController的index
 *  @param animated 是否需要滚动动画
 */
- (void)setCurrentViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
