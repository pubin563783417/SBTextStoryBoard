//
//  SBTextContent.h
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SBTextContentImageLayoutMode) {
    SBTextContentImageLayoutWithNature = -1,
    SBTextContentImageLayoutWithFullScreenWidth = 0
};

/**
 文本类型基础
 */
@interface SBTextContentUnit : NSObject
@property (assign,nonatomic) NSInteger index;
+ (id)sb_modelWithDictionary:(NSDictionary *)dic;
@end

//超链接
@interface SBTextContentLink :SBTextContentUnit
@property (copy,nonatomic) NSString *url;
@property (strong,nonatomic) UIColor *color;
@property (assign,nonatomic) BOOL allowTap;
@property (strong,nonatomic) UIFont *font;
@property (strong,nonatomic) UIColor *highlightColor;
@property (strong,nonatomic) UIFont *highlightFont;
@property (assign,nonatomic) CGFloat lineSpacing;
@property (assign,nonatomic,readonly) NSRange range;
@property (strong,nonatomic,readonly) NSDictionary *attribute;
//@property (strong,nonatomic) UIColor *color;
@end
//普通文本
@interface SBTextContentText : SBTextContentUnit
@property (copy,nonatomic) NSString *text;
@property (strong,nonatomic) UIColor *color;
@property (strong,nonatomic) UIFont *font;
@property (assign,nonatomic) BOOL allowEdit;
@property (assign,nonatomic) CGFloat lineSpacing;

@property (assign,nonatomic,readonly) NSRange range;
@property (strong,nonatomic,readonly) NSDictionary *attribute;
@end
//换行
@interface SBTextContentBrline : SBTextContentUnit
@end
//图片
@interface SBTextContentImage : SBTextContentUnit

@property (copy,nonatomic) NSString *url;
@property (assign,nonatomic) CGSize size;
@property (assign,nonatomic) BOOL allowTap;
@property (copy,nonatomic) NSString *HDurl;

@property (strong,nonatomic,readonly) NSDictionary *attribute;

@property (assign,nonatomic) SBTextContentImageLayoutMode layoutMode;
@end
//段落结束标记
@interface SBTextContentParagraph : SBTextContentUnit
@end

@interface SBTextContent : NSObject
@property (strong,nonatomic,readonly) NSMutableArray *unitsArray;
+ (instancetype)textContent;
@property (copy,nonatomic) SBTextContent* (^sbtext)(NSString *text,...);
@property (copy,nonatomic) SBTextContent* (^sbimage)(NSString *url,CGSize size,...);
@property (copy,nonatomic) SBTextContent* (^sblink)(NSString *url,...);
@property (copy,nonatomic) SBTextContent* (^sbparagraph)();
@property (copy,nonatomic) SBTextContent* (^sbbrline)();
@end
