//
//  WLLabel.m
//  YWLabelDemo
//
//  Created by 汪亮 on 2018/4/19.
//  Copyright © 2018年 wyw. All rights reserved.
//

#import "WLLabel.h"

@implementation WLLabel

//设置行间距
-(void)labelText:(NSString *)text lineSpacing:(CGFloat)l_spacing
{
    if(l_spacing<=0){
        self.text = text;
        return;
    }
    self.numberOfLines = 0;
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = l_spacing;
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [mAttrStr addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, text.length)];
    [mAttrStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    
    self.attributedText = mAttrStr;
}

//返回富文本
+(NSAttributedString *)attributedTexts:(NSArray *)texts textColors:(NSArray *)textColors textFonts:(NSArray *)textFonts
{
    if(texts.count==0){
        return nil;
    }
    
    NSMutableAttributedString *mResultAttrStr = [[NSMutableAttributedString alloc] init];
    
    for(int i=0; i<texts.count; i++)
    {
        NSString *text = texts[i];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attrStr addAttribute:NSForegroundColorAttributeName value:textColors[i] range:NSMakeRange(0, text.length)];
        [attrStr addAttribute:NSFontAttributeName value:textFonts[i] range:NSMakeRange(0, text.length)];
        [mResultAttrStr appendAttributedString:attrStr];
    }
    return mResultAttrStr.copy;
}
//返回富文本
+ (NSAttributedString *)attributedTexts:(NSArray *)texts textColors:(NSArray *)textColors textFonts:(NSArray *)textFonts lineSpacing:(CGFloat)l_spacing
{
    NSMutableAttributedString *mAttrStr = [self attributedTexts:texts textColors:textColors textFonts:textFonts].mutableCopy;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = l_spacing;
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mAttrStr.length)];
    
    return mAttrStr.copy;
}
//根据富文本内容返回控件尺寸
+(CGSize)sizeLabelWith:(CGFloat)width attributedString:(NSAttributedString *)attributedStr
{
    if(width<0){
        return CGSizeZero;
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    lab.attributedText = attributedStr;
    lab.numberOfLines = 0;
    CGSize fitSize = [lab sizeThatFits:lab.bounds.size];
    
    return fitSize;
}
//根据文本内容+字体 返回控件尺寸
+ (CGSize)sizeLabelWith:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    if(width<0){
        return CGSizeZero;
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    lab.text = text;
    lab.font = font;
    lab.numberOfLines = 0;
    CGSize fitSize = [lab sizeThatFits:lab.bounds.size];
    
    return fitSize;
}
//根据文本内容+字体+行间距 返回控件尺寸
+ (CGSize)sizeLabelWith:(CGFloat)width text:(NSString *)text font:(UIFont *)font lineSpacing:(CGFloat)l_spacing
{
    if(width<0){
        return CGSizeZero;
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [mAttrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = l_spacing;
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    lab.attributedText = mAttrStr.copy;
    lab.font = font;
    lab.numberOfLines = 0;
    CGSize fitSize = [lab sizeThatFits:lab.bounds.size];
    
    return fitSize;
}

// 由多个attributedString拼接成新的attributedString，item意为由text或image生成的单个attributedString
+ (NSAttributedString *)fixAttributeStrWithItems:(NSArray *)items
{
    NSMutableAttributedString *resultMAttrStr = [[NSMutableAttributedString alloc] init];
    for(int i=0; i<items.count; i++)
    {
        if([items[i] isKindOfClass:[NSAttributedString class]]){
            [resultMAttrStr appendAttributedString:items[i]];
        }
    }
    
    return resultMAttrStr;
}



// 图文混合，只有一张图片
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      lineSpacing:(CGFloat)l_spacing
{
    return [[self class] fixAttributedStrWithTexts:texts
                                        textColors:colors
                                         textfonts:fonts
                                             image:image
                                       insertIndex:index
                                       imageBounds:CGRectZero
                                       lineSpacing:l_spacing];
}


// 同上，多了一个l_spacing参数
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      imageBounds:(CGRect)bounds
                                      lineSpacing:(CGFloat)l_spacing

{
    if(texts.count==0){
        return nil;
    }
    
    NSMutableAttributedString *resultAttrStr = [[NSMutableAttributedString alloc] init];
    NSInteger locationIndex = 0;
    for(int i=0; i<texts.count; i++)
    {
        NSString *text = texts[i];
        NSAttributedString *tempMAttrStr = [[self class] attributedStrWithText:texts[i] textColor:colors[i] textFont:fonts[i]];
        [resultAttrStr appendAttributedString:tempMAttrStr];
        
        // 计算图片应该插入的位置
        if(index<=texts.count){
            if(index == 0){
                locationIndex = 0;
            }
            else{
                if(i<index){
                    locationIndex+=text.length;
                }
            }
        }
        
    }
    if(l_spacing>0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = l_spacing;
        [resultAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, resultAttrStr.length)];
    }
    
    // 插入图片附件（插入图片要在最后，不然会有影响）
    NSMutableAttributedString *resultAttrStr1 = [[self class] insertMAttrStr:resultAttrStr image:image imageBounds:bounds insertIndex:locationIndex];
    
    
    return resultAttrStr1;
}



+ (NSMutableAttributedString *)insertMAttrStr:(NSMutableAttributedString *)mAttrStr image:(UIImage *)image imageBounds:(CGRect)bounds insertIndex:(NSInteger)index
{
    if(image){
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
        NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [mAttrStr insertAttributedString:attachmentAttrStr atIndex:index];
    }
    
    return [mAttrStr copy];
}




// 由text生成attributedString
+ (NSAttributedString *)attributedStrWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font
{
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [mAttrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length)];
    [mAttrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    
    return mAttrStr;
}

// 由image生成attributedString
+ (NSAttributedString *)attributedStrWithImage:(UIImage *)image imageBounds:(CGRect)bounds
{
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    return attachmentAttrStr;
}

@end
