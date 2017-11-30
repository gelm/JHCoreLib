//
//  JHBaseCell.m
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/15.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseCell.h"

const UILineRectInsets UIRectInsetsZero = (UILineRectInsets){0,0,0,0};

@implementation JHBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.cellLineRectInset = UIRectInsetsZero;
        
        _topSeparatorLine = [[UIImageView alloc]initWithImage:[self.class buildImageWithColor:[self.class separatorLineColor]]];
        [self.contentView addSubview:_topSeparatorLine];
        
        _bottomSeparatorLine = [[UIImageView alloc]initWithImage:[self.class buildImageWithColor:[self.class separatorLineColor]]];
        [self.contentView addSubview:_bottomSeparatorLine];
        
        self.cellLineStyle = CellLineOfBottom;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    _topSeparatorLine.frame = CGRectMake(0 + _cellLineRectInset.offsetX, 0 + _cellLineRectInset.offsetY, width + _cellLineRectInset.offsetW, 0.6 + _cellLineRectInset.offsetH);
    _bottomSeparatorLine.frame = CGRectMake(0 + _cellLineRectInset.offsetX, height - 0.6 + _cellLineRectInset.offsetY, width + _cellLineRectInset.offsetW, 0.6 + _cellLineRectInset.offsetH);
}

-(void)setCellLineStyle:(CellLineStyle)cellLineStyle{
    switch (cellLineStyle) {
        case CellLineOfTop:
            _topSeparatorLine.hidden = NO;
            _bottomSeparatorLine.hidden = YES;
            break;
            
        case CellLineOfBottom:
            _topSeparatorLine.hidden = YES;
            _bottomSeparatorLine.hidden = NO;
            break;
            
        case CellLineOfBoth:
            _topSeparatorLine.hidden = NO;
            _bottomSeparatorLine.hidden = NO;
            break;
            
        default:
            _topSeparatorLine.hidden = YES;
            _bottomSeparatorLine.hidden = YES;
            break;
    }
}

#pragma mark --JHBaseCellDatasource

+ (BOOL)isFixedHeight {
    return YES;
}

- (CGFloat)height {
    return 44;
}

+ (UIColor *)separatorLineColor {
    return [UIColor grayColor];
}

#pragma mark --tool method

+ (UIImage *) buildImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
