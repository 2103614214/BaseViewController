//
//  ShowAnimationView.m
//  daweiying
//
//  Created by 汪亮 on 2017/10/31.
//  Copyright © 2017年 大维营(深圳)科技有限公司. All rights reserved.
//

#import "ShowAnimationView.h"

@interface ShowAnimationView ()

@property (nonatomic, strong) UIView  *contentView;
@end

@implementation ShowAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void)layoutAllSubviews{
    
    /*创建灰色背景*/
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.alpha = 0.3;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    
    
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    [bgView addGestureRecognizer:tapGesture];
    
}
#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    
    [self dismissContactView];
}

-(void)dismissContactView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        self.isOpen = NO;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

// 这里加载在了window上
-(void)showView
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.isOpen = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
