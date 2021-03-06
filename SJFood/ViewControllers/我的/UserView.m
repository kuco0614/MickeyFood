//
//  UserView.m
//  SJFood
//
//  Created by 叶帆 on 14/12/5.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "UserView.h"

@implementation UserView
@synthesize iconImageView,loginButton;
@synthesize deliveryView,receiveView,commentView;

#pragma mark - Private Methods
- (void)setBadgeViewWithView:(UIView *)parentView badgeNum:(NSString *)badgeNum
{
    if (![badgeNum isEqualToString:@"0"]) {
        YFBadgeView *badgeView = [[YFBadgeView alloc]initWithParentView:parentView alignment:YFBadgeViewAlignmentTopRight];
        badgeView.badgeText = badgeNum;
    }
}

#pragma mark - Public Methods
- (void)reloadWithUserInfo:(MineInfo *)mineInfo
{
    self.loginButton.enabled = NO;
    [self.loginButton setTitle:mineInfo.userInfo.nickname forState:UIControlStateNormal];
    //头像
    self.iconImageView.cacheDir = kUserIconCacheDir;
    [self.iconImageView aysnLoadImageWithUrl:mineInfo.userInfo.imgUrl placeHolder:@"icon_user_image_defult.png"];
    
    //角标
    [self setBadgeViewWithView:self.deliveryView badgeNum:mineInfo.waitDeliveryOrder];
    [self setBadgeViewWithView:self.receiveView badgeNum:mineInfo.waitReceiveOrder];
    [self setBadgeViewWithView:self.commentView badgeNum:mineInfo.waitCommentOrder];
}

#pragma mark - IBAction Methods
- (IBAction)loginButtonClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginViewNotification object:nil];
}

- (IBAction)deleveryButtonClicked:(id)sender {
    if ([self showLoginViewController]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowUserInfoViewNotification object:@"DeliveryViewController"];
    }
}

- (IBAction)receiveButtonClicked:(id)sender {
    if ([self showLoginViewController]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowUserInfoViewNotification object:@"ReceiveViewController"];
    }
}

- (IBAction)commentButtonClicked:(id)sender {
    if ([self showLoginViewController]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowUserInfoViewNotification object:@"CommentViewController"];
    }
}



#pragma mark - UIView methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.loginButton.enabled = YES;
    self.iconImageView.layer.cornerRadius = 37.f;
    self.iconImageView.layer.borderWidth =  2.5f;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.masksToBounds = YES;
}

@end
