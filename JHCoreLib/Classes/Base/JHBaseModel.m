//
//  JHBaseModel.m
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseModel.h"
#import "MJExtension.h"

@implementation JHBaseModel

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self.class allocWithZone:zone] init];
}

+ (void)initialize {
    __weak typeof(self)weakSelf = self;
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        return [strongSelf JSONKeyPathsByPropertyKey];
    }];
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        return [strongSelf JSONObjectClassInArrayProperty];
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSDictionary *)JSONObjectClassInArrayProperty {
    return @{};
}

@end
