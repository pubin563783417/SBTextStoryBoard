//
//  SBTextStoryBoard.h
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTextContent.h"
@interface SBTextStoryBoard : UIView
///普通文本
@property (nonatomic ,strong) NSString * text;
///字体
@property (nonatomic ,strong) UIFont * font;
///富文本
@property (nonatomic ,strong) NSAttributedString * attributedText;
///文本区域内距
@property (nonatomic ,assign) UIEdgeInsets contentInsets;

///文本颜色
@property (nonatomic ,strong) UIColor * textColor;
//文本链
@property (nonatomic,strong) SBTextContent *contentChain;
///行数
@property (nonatomic ,assign) NSUInteger numberOfLines;

///断行模式
@property (nonatomic ,assign) NSLineBreakMode lineBreakMode;



///水平对齐方式
@property (nonatomic ,assign) NSTextAlignment textAlignment;

///行间距
@property (nonatomic ,assign) CGFloat lineSpacing;
//字体间距
@property (nonatomic,assign) CGFloat fontSpacing;
//段落间距
@property (nonatomic,assign) CGFloat paragraphSpacing;
@end
