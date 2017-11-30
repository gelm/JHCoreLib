//
//  JHAppDataManager.m
//  JHCoreLib
//
//  Created by 各连明 on 2017/11/30.
//

#import "JHAppDataManager.h"

NSString * const appDidLogoutNotification = @"appDidLogoutNotification";
NSString * const appDidLoginNotification = @"appDidLoginNotification";
NSString * const appNeedToLoginNotification = @"appNeedToLoginNotification";

static NSString *const keyUserId = @"keyUserId";
static NSString *const keyMallUserId = @"keyMallUserId";
static NSString *const keyToken = @"keyToken";
static NSString *const keyDeviceToken = @"keyDeviceToken";
static NSString *const keyLastShowOptionTime = @"keyLastShowOptionTime";
static NSString *const keyLoginMode = @"keyLoginMode";
static NSString *const keyNick = @"keyNick";
static NSString *const keyAvatarUrl = @"keyAvatarUrl";

@interface JHAppDataManager ()

@property (nonatomic, readonly) NSUserDefaults* userDefaults;

@end

@implementation JHAppDataManager

+ (instancetype)defaultManager {
    static JHAppDataManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHAppDataManager alloc] init];
    });
    return instance;
}

- (NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

- (void)setUserId:(NSString *)userId {
    if(!userId.length){
        [self.userDefaults removeObjectForKey:keyUserId];
        [self.userDefaults synchronize];
        return;
    }
    [self.userDefaults setObject:userId forKey:keyUserId];
    [self.userDefaults synchronize];
}

- (NSString *)userId {
    return [self.userDefaults objectForKey:keyUserId]?[self.userDefaults objectForKey:keyUserId]:@"";
}

- (void)setMallUserId:(NSString *)mallUserId {
    if(!mallUserId.length){
        [self.userDefaults removeObjectForKey:keyMallUserId];
        [self.userDefaults synchronize];
        return;
    }
    [self.userDefaults setValue:mallUserId forKey:keyMallUserId];
    [self.userDefaults synchronize];
}

- (NSString *)mallUserId {
    if(!self.hasLogin){
        return @"";
    }
    return [self.userDefaults objectForKey:keyMallUserId]?[self.userDefaults objectForKey:keyMallUserId]:@"";
}

- (void)setLoginMode:(LoginMode)loginMode {
    [self.userDefaults setObject:@(loginMode) forKey:keyLoginMode];
    [self.userDefaults synchronize];
}

- (LoginMode)loginMode {
    if(!self.hasLogin){
        return LoginModeNone;
    }
    return [[self.userDefaults objectForKey:keyLoginMode] integerValue];
}

-(BOOL)hasLogin {
    return self.userId.length?YES:NO;
}

- (void)logout {
    [self setUserId:nil];
    [self setMallUserId:nil];
    [self setNick:nil];
    [self setToken:nil];
    [self setAvatarUrl:nil];
}

- (void)loginWithUserId:(NSString *)userId {
    if (userId) {
        userId = [NSString stringWithFormat:@"%@",userId];
        [self setUserId:userId];
    }
    
}

- (void)setToken:(NSString *)token {
    if (!token.length) {
        [self.userDefaults removeObjectForKey:keyToken];
        [self.userDefaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:appDidLogoutNotification object:nil];
        return;
    }
    
    [self.userDefaults setValue:token forKey:keyToken];
    [self.userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:appDidLoginNotification object:nil];
}

- (NSString *)token {
    if(!self.hasLogin){
        return @"";
    }
    return [self.userDefaults valueForKey:keyToken]?[self.userDefaults valueForKey:keyToken]:@"";
}

- (void)setNick:(NSString *)nick {
    if(!nick.length){
        [self.userDefaults removeObjectForKey:keyNick];
        [self.userDefaults synchronize];
        return;
    }
    [self.userDefaults setValue:nick forKey:keyNick];
    [self.userDefaults synchronize];
}

- (NSString *)nick {
    if(!self.hasLogin){
        return @"";
    }
    return [self.userDefaults objectForKey:keyNick]?[self.userDefaults objectForKey:keyNick]:@"";
}

- (void)setAvatarUrl:(NSString *)avatarUrl {
    if(!avatarUrl.length){
        [self.userDefaults removeObjectForKey:keyAvatarUrl];
        [self.userDefaults synchronize];
        return;
    }
    [self.userDefaults setValue:avatarUrl forKey:keyAvatarUrl];
    [self.userDefaults synchronize];
}

- (NSString *)avatarUrl {
    if(!self.hasLogin){
        return @"";
    }
    return [self.userDefaults objectForKey:keyAvatarUrl]?[self.userDefaults objectForKey:keyAvatarUrl]:@"";
}

- (void)setDeviceToken:(NSString *)deviceToken {
    [self.userDefaults setValue:deviceToken forKey:keyDeviceToken];
    [self.userDefaults synchronize];
}

- (NSString *)deviceToken {
    NSString *token = [self.userDefaults valueForKey:keyDeviceToken];
    NSString *subToken = token.length?token:@"deviceToken not found";
    return subToken;
}

- (void)setLastShowOptionTime:(NSDate *)lastShowOptionTime {
    [self.userDefaults setValue:lastShowOptionTime forKey:keyLastShowOptionTime];
    [self.userDefaults synchronize];
}

- (NSDate *)lastShowOptionTime {
    return [self.userDefaults valueForKey:keyLastShowOptionTime];
}

@end
