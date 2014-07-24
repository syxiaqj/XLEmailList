//
//  XLEmailListView.m
//  XLEmailList
//
//  Created by xqj on 14-7-24.
//  Copyright (c) 2014年 renhe. All rights reserved.
//

#import "XLEmailListView.h"

#define EMAIL_CELL_HEIGHT   40.0

@implementation XLEmailListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubviews];
        [self setSubviews];
        
        emailList = [NSMutableArray array];
    }
    return self;
}

- (void)addSubviews
{
    emailTF = [[UITextField alloc] init];
    [self addSubview:emailTF];
    
    emailTbv = [[UITableView alloc] init];
    [self addSubview:emailTbv];
}

- (void)setSubviews
{
    emailTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [emailTF addTarget:self
                action:@selector(inputChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    emailTbv.delegate = self;
    emailTbv.dataSource = self;
    emailTbv.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [emailTbv bringSubviewToFront:[self superview]];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    emailTF.frame = (CGRect){
        5.0, 0, width - 5.0 * 2, height
    };
    
    emailTbv.frame = (CGRect){
        0, height, width, EMAIL_CELL_HEIGHT * 3
    };
}

#pragma mark - Pri

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.y < CGRectGetMaxY(emailTbv.frame))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - SEL

- (void)inputChanged:(UITextField *)textField
{
    NSString *text = textField.text;
    
    NSRange range = [text rangeOfString:@"@"];
    
    emailTbv.hidden = YES;
    
    if (range.length != 1) { return; }
    
    [emailList removeAllObjects];
    
    NSString *prefixString = [text substringToIndex:range.location];
    NSString *suffixString = [text substringFromIndex:range.location];
    
    for (NSString *atString in self.atList)
    {
        if ([atString hasPrefix:suffixString])
        {
            NSString *emailString = [prefixString stringByAppendingString:atString];
            
            [emailList addObject:emailString];
        }
    }
    
    if (emailList.count > 0)
    {
        emailTbv.hidden = NO;
        [emailTbv reloadData];
    }
    
}

#pragma mark - Pub

- (NSString *)value
{
    return emailTF.text;
}

#pragma mark - UITableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return emailList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return EMAIL_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"EmailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifiter];
    }
    
    cell.textLabel.text = emailList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    emailTF.text = emailList[indexPath.row];
    emailTbv.hidden = YES;
}

@end
