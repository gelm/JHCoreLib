//
//  JHViewController.m
//  JHCoreLib
//
//  Created by gelm on 11/30/2017.
//  Copyright (c) 2017 gelm. All rights reserved.
//

#import "JHViewController.h"
#import "JHTestViewController.h"

@interface JHViewController ()

@end

@implementation JHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JHTestViewController *viewController = [[JHTestViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
