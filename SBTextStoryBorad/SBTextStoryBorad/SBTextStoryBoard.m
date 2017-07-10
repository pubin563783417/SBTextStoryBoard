//
//  SBTextStoryBoard.m
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBTextStoryBoard.h"
#import "SBAsyncLayer.h"
#import "SBTextLayout.h"
@implementation SBTextStoryBoard
{
    SBTextLayout *_layout;
}

#pragma mark - private func
- (void)_setLayoutNeedRedraw {
    [self.layer setNeedsDisplay];
}
+ (Class)layerClass {
    return [SBAsyncLayer class];
}
#pragma mark - initiaze
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}
- (void)_initialize{
    _numberOfLines = 1;
    _layout = [[SBTextLayout alloc] init];
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:15];
    self.textAlignment = NSTextAlignmentLeft;
    self.lineSpacing = 5.f;
    self.paragraphSpacing = 20.f;
}
#pragma mark - overlist
- (void)setContentChain:(SBTextContent *)contentChain{
    _contentChain = contentChain;
    [self _initializeLayout];
    [self _clearContents];
    [_layout configLayoutWithContent:contentChain];
    [self _setLayoutNeedRedraw];
}
#pragma mark - overwrite
- (void)setText:(NSString *)text{
    if (text) {
        self.attributedText = [[NSAttributedString alloc]initWithString:text];
    }
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    _attributedText = attributedText;
    [self _initializeLayout];
    [self _clearContents];
    if (attributedText) {
        [self _setLayoutNeedRedraw];
    }
}

- (void)setFont:(UIFont *)font{
    _font = font;
    _layout.font = font;
    [self _clearContents];
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _layout.textColor = textColor;
    [self _clearContents];
}
- (void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    _layout.lineSpacing = lineSpacing;
    [self _clearContents];
}
- (void)setNumberOfLines:(NSUInteger)numberOfLines{
    _numberOfLines = numberOfLines;
    _layout.numberOfLines = numberOfLines;
    [self _clearContents];
}
- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    _layout.contentInsets = contentInsets;
    [self _clearContents];
}
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode{
    _lineBreakMode = lineBreakMode;
    _layout.lineBreakMode = lineBreakMode;
    [self _clearContents];
}
- (void)setParagraphSpacing:(CGFloat)paragraphSpacing{
    _paragraphSpacing = paragraphSpacing;
    _layout.paragraphSpacing = paragraphSpacing;
    [self _clearContents];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    _layout.textAlignment = textAlignment;
    [self _clearContents];
}
#pragma mark - dealloc
- (void)_clearContents {
    CGImageRef image = (__bridge_retained CGImageRef)(self.layer.contents);
    self.layer.contents = nil;
    if (image) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            CFRelease(image);
        });
    }
}
- (void)_initializeLayout{
    NSAttributedString *attributeText = _layout.attributedText;
    _layout.attributedText = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [attributeText string];
    });
}
#pragma mark  - layer delegate
- (SBAsyncLayerDisplayTask *)newAsyncDisplayTask{
    SBAsyncLayerDisplayTask *task = [SBAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer){
        //图片和文本标签删除
    };
    task.display = ^(CGContextRef context, CGSize size, BOOL (^isCancelled)(void)){
        [_layout drawInContext:context size:size cancel:isCancelled];
    };
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
        //添加图片
    };
    return task;
}
@end
