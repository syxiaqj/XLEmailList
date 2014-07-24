//
//  XLEmailListView.h
//  XLEmailList
//
//  Created by xqj on 14-7-24.
//  Copyright (c) 2014年 renhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLEmailListView : UIView<UITableViewDelegate, UITableViewDataSource>
{
    UITextField *emailTF;
    UITableView *emailTbv;
    
    NSMutableArray *emailList;
}

@property (nonatomic, strong) NSString *value;
///后缀列表
@property (nonatomic, strong) NSArray *atList;

@end
