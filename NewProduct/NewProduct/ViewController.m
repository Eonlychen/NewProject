//
//  ViewController.m
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import "ViewController.h"
#import "CHCategoryHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    testButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:testButton];
    [testButton addTouchUpInsideAction:^(UIButton *sender) {
        NSLog(@"sender");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
