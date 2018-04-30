//
//  WLLabel.h
//  YWLabelDemo
//
//  Created by 汪亮 on 2018/4/19.
//  Copyright © 2018年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLLabel : UILabel

/* 设置行间距 */
-(void)labelText:(NSString *)text lineSpacing:(CGFloat)l_spacing;

/** 获取富文本
 *  texts ：文本数组
 *  textColors ：文本颜色数组
 *  textFonts ：文本字体数组
 **/
+(NSAttributedString *)attributedTexts:(NSArray *)texts textColors:(NSArray *)textColors textFonts:(NSArray *)textFonts;

/** 获取富文本
 *  texts ：文本数组
 *  textColors ：文本颜色数组
 *  textFonts ：文本字体数组
 *  lineSpacing ：行间距
 **/
+ (NSAttributedString *)attributedTexts:(NSArray *)texts textColors:(NSArray *)textColors textFonts:(NSArray *)textFonts lineSpacing:(CGFloat)l_spacing;

/** 根据富文本内容获取size
 *  attributedString ：富文本
 *  return ：反回size
 **/
+(CGSize)sizeLabelWith:(CGFloat)width attributedString:(NSAttributedString *)attributedStr;

/** 根据文本获取size
 *  text ：普通文本
 *  font ：字体大小
 *  return ：反回size
 **/
+(CGSize)sizeLabelWith:(CGFloat)width text:(NSString *)text font:(UIFont *)font;

/** 根据内容获取size
 *  text ：富文本
 *  font ：字体大小
 *  lineSpacing ：行间距
 *  return ：反回size
 **/
+ (CGSize)sizeLabelWith:(CGFloat)width text:(NSString *)text font:(UIFont *)font lineSpacing:(CGFloat)l_spacing;


/** 拼接多个富文本
 *  items ： 富文本数组
 *  return ：返回数组
 **/
+ (NSAttributedString *)fixAttributeStrWithItems:(NSArray *)items;


/** 设置一张图片
 *  texts ：    文本数组
 *  colors ：   颜色数组
 *  image ：    字体数组
 *  index ：    图片
 *  l_spacing ：行间距
 **/
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      lineSpacing:(CGFloat)l_spacing;


/** 设置一张图片 (可设置frame)
 *  texts ：    文本数组
 *  colors ：   颜色数组
 *  image ：    字体数组
 *  index ：    图片
 *  l_spacing ：行间距
 **/
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      imageBounds:(CGRect)bounds
                                      lineSpacing:(CGFloat)l_spacing;


/** 生成富文本
 *  text ：  文本
 *  color ： 颜色
 *  font ：  字体
 *  return ：返回富文本
 **/
+ (NSAttributedString *)attributedStrWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;


/** 由image生成富文本
 *  image ：  图片
 *  bounds ： frame
 *  return ：返回富文本
 **/
+ (NSAttributedString *)attributedStrWithImage:(UIImage *)image imageBounds:(CGRect)bounds;


@end
