//
//  JHBasePageViewController.m
//  JHModuleDemo
//
//  Created by 各连明 on 2016/12/12.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBasePageViewController.h"

@interface JHBasePageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation JHBasePageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(4)}];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        _pageScrollView = [self aScrollViewOfView:_pageViewController.view];
        _pageScrollView.scrollEnabled = [self pageScrollEnabled];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_pageViewController willMoveToParentViewController:self];
    [self addChildViewController:_pageViewController];
    [_pageViewController didMoveToParentViewController:self];
    
    CGRect pageViewFrame = self.view.bounds;
    UIView *segmentControl = [self customSegmentedControl];
    if(segmentControl){
        CGRect segmentFrame,remainFrame;
        CGRectDivide(pageViewFrame, &segmentFrame, &remainFrame, CGRectGetHeight(segmentControl.bounds), CGRectMinYEdge);
        pageViewFrame = remainFrame;
        segmentControl.frame = segmentFrame;
        [self.view addSubview:segmentControl];
    }
    _pageViewController.view.frame = pageViewFrame;
    [self.view addSubview:_pageViewController.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -can rewrite methods

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    [self setViewControllerAtIndex:[self defaultIndex] animated:NO];
}

- (NSInteger)defaultIndex {
    return 0;
}

- (BOOL)pageScrollEnabled {
    return YES;
}

- (UIView *)customSegmentedControl {
    return nil;
}

- (void)setCurrentViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    [self setViewControllerAtIndex:index animated:animated];
}

#pragma mark --private methods

- (void)setViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    if(index < 0){
        index = 0;
    }else if (index > _viewControllers.count - 1){
        index = _viewControllers.count - 1;
    }
    NSInteger currentIndex = [_viewControllers indexOfObject:_pageViewController.viewControllers.firstObject];
    if(index < currentIndex){
        [_pageViewController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:nil];
    }else if (index > currentIndex){
        [_pageViewController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
    }
}

- (UIScrollView*)aScrollViewOfView:(UIView*)view {
    for (UIView* v in [view subviews]) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView*)v;
        } else {
            [self aScrollViewOfView:v];
        }
    }
    return nil;
}

#pragma mark --UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if(!_viewControllers.count){
        return nil;
    }
    NSUInteger currentIndex = [_viewControllers indexOfObject:viewController];
    
    if(currentIndex <= 0){
        return nil;
    }
    
    return [_viewControllers objectAtIndex:currentIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if(!_viewControllers.count){
        return nil;
    }
    NSUInteger currentIndex = [_viewControllers indexOfObject:viewController];
    if(currentIndex >= _viewControllers.count - 1){
        return nil;
    }
    return [_viewControllers objectAtIndex:currentIndex+1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"%@",NSStringFromCGPoint(_pageScrollView.contentOffset));
    if (completed) {
        NSUInteger currentIndex = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
        NSUInteger previousIndex = [_viewControllers indexOfObject:previousViewControllers.firstObject];
        if([self respondsToSelector:@selector(pageViewScrollToIndex:previousIndex:)]){
            [self pageViewScrollToIndex:currentIndex previousIndex:previousIndex];
        }
    }
}

@end
