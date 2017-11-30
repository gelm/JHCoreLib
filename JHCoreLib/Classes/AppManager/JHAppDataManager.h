//
//  JHAppDataManager.h
//  JHCoreLib
//
//  Created by 各连明 on 2017/11/30.
//

#import <Foundation/Foundation.h>

//通知
extern NSString * const appDidLogoutNotification;
extern NSString * const appDidLoginNotification;
extern NSString * const appNeedToLoginNotification;

typedef NS_ENUM(NSInteger, LoginMode) {
    LoginModeNone = 0,//未登录
    LoginModeWeixin,
    LoginModeQQ,
    LoginModeSina,
    LoginModePhone,
};

//这个类主要管理用户登录后userId、token等一些重要且唯一的信息
@interface JHAppDataManager : NSObject

/*
 *单例，不要在创建其他的实例，在应用的生命周期内一直使用这个单例
 */
+ (instancetype)defaultManager;

@property (nonatomic, readwrite, copy) NSString *userId;//登录标示，也就是userId，也可以通过下面的实例方法赋值
@property (nonatomic, readwrite, copy) NSString *mallUserId;//用于商城的userId
@property (nonatomic, readwrite, assign) LoginMode loginMode;//1是微信，2是QQ，3是新浪微博，4是手机账号
@property (nonatomic, readwrite, copy) NSString *nick;
@property (nonatomic, readwrite, copy) NSString *avatarUrl;//头像地址

@property (nonatomic, readwrite, copy) NSString *token;//用户token
@property (nonatomic, readwrite, copy) NSString *deviceToken;//设备token，用于remote notification
@property (nonatomic, readwrite, strong) NSDate *lastShowOptionTime;
@property (nonatomic, readonly) BOOL hasLogin;//判断使用是否登录
/*
 *   一切代表登录成功的操作后都要调用此方法，设置用户的userId后代表用户已经登录，和上面的属性loginIdentifier相同
 *
 *   @param identifier参数代表用户的唯一标识符，也就是userId
 */
- (void)loginWithUserId:(NSString *)userId;
/*
 *   退出操作，会将以上保存的用户的信息清除掉，代表该用户已经退出。在调用服务器退出请求且请求成功后必须调用此方法。
 */
- (void)logout;

@end
