//
//  JHAppManager.h
//  JHCoreLib
//
//  Created by 各连明 on 2017/11/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//管理应用的层级关系以及rooViewController
@interface JHAppManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, strong, readwrite) Class navigationControllerClass;//配置所需要的导航栏控制器Class
@property (nonatomic, strong, readwrite) Class tabBarControllerClass;//配置所需要的TabBarControllerClass

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

- (UIViewController *)topViewController;//返回顶层的viewController

- (UINavigationController *)aNavigationControllerWithRootViewController:(UIViewController*)viewController;

@end
