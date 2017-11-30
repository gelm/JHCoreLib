//
//  JHAppManager.m
//  JHCoreLib
//
//  Created by 各连明 on 2017/11/30.
//

#import "JHAppManager.h"

@implementation JHAppManager

+ (instancetype)shareManager {
    static JHAppManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHAppManager alloc]init];
    });
    return manager;
}

@synthesize rootViewController = _rootViewController;

- (UIViewController *)rootViewController {
    if(!_rootViewController){
        Class tabBarControllerClass = _tabBarControllerClass?_tabBarControllerClass:[UITabBarController class];
        _rootViewController = [[tabBarControllerClass alloc]init];
    }
    return _rootViewController;
}

- (UINavigationController *)aNavigationControllerWithRootViewController:(UIViewController*)viewController {
    Class navigationClass = _navigationControllerClass?_navigationControllerClass:[UINavigationController class];
    UINavigationController *navigationController = [[navigationClass alloc]initWithRootViewController:viewController];
    return navigationController;
}

- (UIViewController *)topViewController {
    UIViewController *topViewController = self.rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    if([topViewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarController = (UITabBarController *)topViewController;
        topViewController = [tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex];
    }
    if([topViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)topViewController;
        topViewController = nav.topViewController;
    }
    return topViewController;
}


@end
