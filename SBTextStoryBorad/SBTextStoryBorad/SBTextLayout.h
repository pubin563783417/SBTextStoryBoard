//
//  SBTextLayout.h
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@class SBTextContent;
@interface SBTextLayout : NSObject


- (void)drawInContext:(CGContextRef)context
                 size:(CGSize)size
               cancel:(BOOL (^)(void))cancel;

- (void)configLayoutWithContent:(SBTextContent *)content;
///< CTFrameSetter
@property (nonatomic, readonly) CTFramesetterRef frameSetter;
///< CTFrame
@property (nonatomic, readonly) CTFrameRef frame;
@property (nonatomic, readonly) SBTextContent * content;

@property (nonatomic ,strong) NSMutableAttributedString * attributedText;
@property (nonatomic ,strong) UIFont * font;
@property (nonatomic ,assign) NSTextAlignment textAlignment;
@property (nonatomic ,assign) NSLineBreakMode lineBreakMode;
@property (nonatomic ,assign) CGFloat lineSpacing;
@property (nonatomic ,assign) UIEdgeInsets contentInsets;
@property (nonatomic ,strong) UIColor * textColor;
@property (nonatomic ,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) CGFloat fontSpacing;
@property (nonatomic,assign) CGFloat paragraphSpacing;
@end
