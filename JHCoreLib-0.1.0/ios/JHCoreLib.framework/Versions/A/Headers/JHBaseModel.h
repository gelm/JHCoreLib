//
//  JHBaseModel.h
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHBaseModel : NSObject<NSCopying>

/**
 *  对象属相和服务器的键值关联
 *
 *  @return 映射键值对
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey;
/**
 *  在array属性中是什么对象class
 *
 *  @return 映射键值对
 */
+ (NSDictionary *)JSONObjectClassInArrayProperty;

@end
