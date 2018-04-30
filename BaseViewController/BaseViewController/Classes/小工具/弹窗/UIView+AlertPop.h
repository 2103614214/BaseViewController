//
//  UIView+AlertPop.h
//  ShowAlertView
//
//  Created by 汪亮 on 2018/3/13.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(UIButton * _Nullable button,NSInteger didRow);

@interface UIView (AlertPop)

/** 只弹出文字列表
 *  array ：弹出的选项标题
 *  textColor ：选项标题的字体颜色 可设置两种类型，数组颜色或者单个颜色（NSArray/UIColor）
 *  font ：选项标题的字体
 *  取消 按钮字体请到.m文件自行设置。默认黑色-16号
 **/
-(void)createAlertViewTitleArray:(NSArray* _Nullable )array textColor:(id _Nullable )color font:(UIFont*_Nullable)font actionBlock:(AlertBlock _Nullable )actionBlock;

/** 弹出图标+文字样式
 *  array ：弹出的选项标题
 *  arrayImage ：数组图标，没有写nil
 *  textColor ：选项标题的字体颜色 可设置两种类型，数组颜色或者单个颜色（NSArray/UIColor）
 *  font ：选项标题的字体
 *  spacing ：文字与图片间距自行调试（无图片可填0）
 *  取消 按钮字体请到.m文件自行设置。默认黑色-16号
 **/
-(void)createAlertViewTitleArray:(NSArray* _Nullable )array arrayImage:(NSArray* _Nullable )arrayImage textColor:(id _Nullable )color font:(UIFont*_Nullable)font spacing:(CGFloat)spacing actionBlock:(AlertBlock _Nullable )actionBlock;

@end
