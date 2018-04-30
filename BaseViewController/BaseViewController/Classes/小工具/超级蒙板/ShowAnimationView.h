//
//  ShowAnimationView.h
//  daweiying
//
//  Created by 汪亮 on 2017/10/31.
//  Copyright © 2017年 大维营(深圳)科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAnimationView : UIView

-(void)showView;

-(void)dismissContactView;

/** 是否显示 */
@property(nonatomic,assign)BOOL isOpen;

@end
