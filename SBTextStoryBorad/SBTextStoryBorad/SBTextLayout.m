//
//  SBTextLayout.m
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBTextLayout.h"
#import "SBTextContent.h"
@interface SBTextLayout()
///< CTFrameSetter
@property (nonatomic,readwrite) CTFramesetterRef frameSetter;
///< CTFrame
@property (nonatomic,readwrite) CTFrameRef frame;
@end
@implementation SBTextLayout
{
    NSInteger _index;
}
- (void)drawInContext:(CGContextRef)context
               size:(CGSize)size
               cancel:(BOOL (^)(void))cancel{
    if (cancel()) return;
    CGContextTranslateCTM(context,0,size.height);
    CGContextScaleCTM(context,1.0,-1.0);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedText);
    _frameSetter = framesetter;
    CGMutablePathRef path = [self calculatePathWithSize:size];
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    _frame = frame;
    CTFrameDraw(frame, context);
    CGPathRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
}
- (void)configLayoutWithContent:(SBTextContent *)content{
    _attributedText = [NSMutableAttributedString new];
    for (SBTextContentUnit *unit in content.unitsArray) {
        //换行
        if ([unit isMemberOfClass:[SBTextContentBrline class]]) {
            [self brline];
        }else if ([unit isMemberOfClass:[SBTextContentParagraph class]]){
            //段落
            [self brparagraph];
        }else if ([unit isMemberOfClass:[SBTextContentText class]]){
            //文本
            [self nomalText:unit];
        }else if ([unit isMemberOfClass:[SBTextContentLink class]]){
            //链接
            [self link:unit];
        }
        
    }
    
}
- (void)brline{
    [_attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}
- (void)brparagraph{
    
}
- (void)nomalText:(SBTextContentUnit *)unit{
    NSMutableDictionary *textAttributeDict = [self unitAttribute:(SBTextContentText *)unit];
    [textAttributeDict setObject:(id)[self defaultsParagraphAttribute] forKey:(id)kCTParagraphStyleAttributeName];
    
    NSAttributedString *textAttribute = [[NSAttributedString alloc] initWithString:((SBTextContentText *)unit).text attributes:textAttributeDict];
    [_attributedText appendAttributedString:textAttribute];
}
- (void)link:(SBTextContentUnit *)unit{
    NSMutableDictionary *textAttributeDict = [NSMutableDictionary new];
    [textAttributeDict setObject:(id)[self defaultsParagraphAttribute] forKey:(id)kCTParagraphStyleAttributeName];
    [self linkAttributeSetting:textAttributeDict contentLink:(SBTextContentLink *)unit];
    NSAttributedString *textAttribute = [[NSAttributedString alloc] initWithString:((SBTextContentLink *)unit).url attributes:textAttributeDict];
    [_attributedText appendAttributedString:textAttribute];
}
#pragma mark - formatsetting
- (void)linkAttributeSetting:(NSMutableDictionary *)linkAttributeDict contentLink:(SBTextContentLink *)content{
    [linkAttributeDict setObject:content.color?:[UIColor blueColor] forKey:(id)NSForegroundColorAttributeName];
    [linkAttributeDict setObject:content.font?:_font forKey:(id)NSFontAttributeName];
    CGFloat lineSpacing = content.lineSpacing > 0?:_lineSpacing;
    CFNumberRef number = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&lineSpacing);
    [linkAttributeDict setObject:(__bridge id)number forKey:(id)kCTKernAttributeName];
}
- (NSMutableDictionary *)unitAttribute:(SBTextContentText *)content{
    UIFont *font = [content.font copy]?:_font;
//    CTFontRef ctfont = CTFontCreateWithName((CFStringRef)font.fontName,font.pointSize,NULL);
    UIColor *textColor = [content.color copy]?:_textColor;
    CGFloat fontSpacing = _fontSpacing;
    NSMutableDictionary * attributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 font,(id)NSFontAttributeName,
                                textColor,(id)NSForegroundColorAttributeName,@(fontSpacing),(id)NSKernAttributeName,nil];
    return attributes;
}
- (CTParagraphStyleRef)defaultsParagraphAttribute{
    //创建文本对齐方式
    CTTextAlignment alignment = (CTTextAlignment)_textAlignment;//
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize=sizeof(CTTextAlignment);
    alignmentStyle.value=&alignment;
    
    //首行缩进
    CGFloat fristlineindent = 24.0f;
    CTParagraphStyleSetting fristline;
    fristline.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    fristline.value = &fristlineindent;
    fristline.valueSize = sizeof(CGFloat);
    //换行模式
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = (CTLineBreakMode)_lineBreakMode;//kCTLineBreakByWordWrapping;//换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    //行距
    CTParagraphStyleSetting lineSpaceSetting;
    lineSpaceSetting.spec = kCTParagraphStyleSpecifierLineSpacing;
    lineSpaceSetting.value = &_lineSpacing;
    lineSpaceSetting.valueSize = sizeof(CGFloat);
    
    //段前间隔
    CGFloat paragraphspace = 5.0f;
    CTParagraphStyleSetting paragraph;
    paragraph.spec = kCTParagraphStyleSpecifierLineSpacing;
    paragraph.value = &paragraphspace;
    paragraph.valueSize = sizeof(CGFloat);
    
    //组合设置
    CTParagraphStyleSetting settings[] = {
        alignmentStyle,
        fristline,
        lineBreakMode,
        lineSpaceSetting,
        paragraphspace
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, sizeof(settings));
   
//    CFRelease(style);
    return style;
}
#pragma mark -  cgpath
- (CGMutablePathRef)calculatePathWithSize:(CGSize)size{
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(_contentInsets.left, _contentInsets.top ,size.width-2*_contentInsets.left , size.height-2*_contentInsets.top));
    return Path;
}
@end
