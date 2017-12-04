//
//  JHBaseViewController.m
//  JHModuleDemo
//
//  Created by 各连明 on 2016/11/3.
//  Copyright © 2016年 glm. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if(_datasource && [_datasource respondsToSelector:@selector(leftItemViews)]){
        [self addItemForLeft:YES withItem:[_datasource leftItemViews] spaceWidth:0];
    }else{
        if([self leftItemViews]){
            [self addItemForLeft:YES withItem:[self leftItemViews] spaceWidth:0];
        }else{
            if([self shouldShowBackItem]){
                [self showBackItem];
            }else{
                self.navigationItem.hidesBackButton = YES;
            }
        }
    }
    
    if(_datasource && [_datasource respondsToSelector:@selector(rightItemViews)]){
        [self addItemForLeft:NO withItem:[_datasource rightItemViews] spaceWidth:0];
    }else{
        [self addItemForLeft:NO withItem:[self rightItemViews] spaceWidth:0];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL hidden = (_datasource && [_datasource respondsToSelector:@selector(shouldHideNavigationBar)])?[_datasource shouldHideNavigationBar]:[self shouldHideNavigationBar];
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

- (id)leftItemViews {
    return nil;
}

- (id)rightItemViews {
    return nil;
}

- (BOOL)shouldHideNavigationBar {
    return NO;
}

- (BOOL)shouldShowBackItem {
    return YES;
}

- (void)showBackItem {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [btn sizeToFit];
    [btn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addItemForLeft:YES withItem:btn spaceWidth:0];
}

- (void)backItemAction:(UIButton*)button {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)addItemForLeft:(BOOL)left withItem:(id)item spaceWidth:(CGFloat)width {
    if(item == nil){
        return;
    }
    
    if([item isKindOfClass:[UIView class]]){
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
        space.width = width - 10;
        
        if (left) {
            self.navigationItem.leftBarButtonItems = @[space,buttonItem];
        } else {
            self.navigationItem.rightBarButtonItems = @[space,buttonItem];
        }
    }else if ([item isKindOfClass:[NSArray class]]){
        NSArray *buttons = (NSArray *)item;
        
        NSMutableArray *array = [NSMutableArray array];
        [buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UIView class]]){
                UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:obj];
                UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                          target:nil action:nil];
                space.width = width - 10;
                [array addObject:space];
                [array addObject:buttonItem];
            }
        }];
        if (left) {
            self.navigationItem.leftBarButtonItems = array;
        } else {
            self.navigationItem.rightBarButtonItems = array;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

