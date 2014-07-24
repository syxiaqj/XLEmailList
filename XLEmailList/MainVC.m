//
//  MainVC.m
//  XLEmailList
//
//  Created by xqj on 14-7-24.
//  Copyright (c) 2014年 renhe. All rights reserved.
//

#import "MainVC.h"
#import "XLEmailListView.h"

@interface MainVC ()

@end

@implementation MainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *atList = @[@"@gmail.com",
                        @"@163.com",
                        @"@qq.com",
                        @"@sina.com",
                        @"@126.com"];
    
    XLEmailListView *emailView = [[XLEmailListView alloc] init];
    emailView.frame = (CGRect){10, 100, 300, 44};
    emailView.layer.borderColor = [UIColor grayColor].CGColor;
    emailView.layer.borderWidth = 1.0;
    emailView.atList = atList;
    [self.view addSubview:emailView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
