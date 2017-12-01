//
//  JHBaseCell.h
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHBaseCellDatasource <NSObject>

@optional
+ (BOOL)isFixedHeight;
- (CGFloat)height;
+ (UIColor *)separatorLineColor;

@end

typedef NS_ENUM(NSInteger, CellLineStyle) {
    CellLineOfNone = 0,
    CellLineOfTop,
    CellLineOfBottom,
    CellLineOfBoth,
};

typedef struct UILineRectInsets {
    CGFloat offsetX, offsetY, offsetW, offsetH;
} UILineRectInsets;

UIKIT_STATIC_INLINE UILineRectInsets UILineRectInsetsMake(CGFloat offsetX, CGFloat offsetY, CGFloat offsetW, CGFloat offsetH) {
    UILineRectInsets insets = (UILineRectInsets){offsetX, offsetY, offsetW, offsetH};
    return insets;
};

UIKIT_EXTERN const UILineRectInsets UIRectInsetsZero;

@interface JHBaseCell : UITableViewCell<JHBaseCellDatasource>

@property (nonatomic, strong, readonly) UIImageView *topSeparatorLine;
@property (nonatomic, strong, readonly) UIImageView *bottomSeparatorLine;
@property (nonatomic, assign) CellLineStyle cellLineStyle;
@property (nonatomic, readwrite) UILineRectInsets cellLineRectInset;

@end
