//
//  SBTextContent.m
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBTextContent.h"
@implementation SBTextContentUnit
- (id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (id)sb_modelWithDictionary:(NSDictionary *)dic{
    id model = [[self alloc]initWithDictionary:dic];
    return model;
}
@end
@interface SBTextContentLink()
@property (assign,nonatomic,readwrite) NSRange range;
@property (strong,nonatomic,readwrite) NSDictionary *attribute;
@end
@implementation SBTextContentLink
- (instancetype)init{
    if (self = [super init]) {
        _allowTap = YES;
    }
    return self;
}
@end
@interface SBTextContentText()
@property (assign,nonatomic,readwrite) NSRange range;
@property (strong,nonatomic,readwrite) NSDictionary *attribute;
@end
@implementation SBTextContentText
@end
@implementation SBTextContentBrline
@end
@implementation SBTextContentImage
- (instancetype)init{
    if (self = [super init]) {
        _allowTap = YES;
    }
    return self;
}
@end
@implementation SBTextContentParagraph
@end
@interface SBTextContent()
@property (strong,nonatomic,readwrite) NSMutableArray *unitsArray;
@end
@implementation SBTextContent
{
    NSAttributedString *_attribute;
}
#pragma mark - initialize
+ (instancetype)textContent{
    SBTextContent *content = [[SBTextContent alloc] init];
    return content;
}
+ (instancetype)textContentWithString:(NSString *)string{
    if (!string) {
        return nil;
    }
    SBTextContent *content = [self textContentWithAttributeString:[[NSAttributedString alloc] initWithString:string]];
    return content;
}
+ (instancetype)textContentWithAttributeString:(NSAttributedString *)attributeString{
    SBTextContent *content = [self textContent];
    content->_attribute = attributeString;
    return content;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _unitsArray = [NSMutableArray new];
    }
    return self;
}
#pragma mark - Unit method

- (SBTextContent* (^)(NSString *text,...))sbtext{
    __weak typeof(self) weak = self;
    return ^(NSString *text,...){
        __strong typeof(weak) strong = weak;
        SBTextContentText *unit = [SBTextContentText new];
        [strong.unitsArray addObject:unit];
        unit.index = strong.unitsArray.count;
        unit.text = text;
        va_list arguments;
        id eachObject;
        if (text) {
            va_start(arguments, text);
            int index = 0;
            while ((eachObject = va_arg(arguments, id))) {
                
                switch (index) {
                    case 0:
                        unit.color = eachObject;
                        break;
                    case 1:
                        unit.font = eachObject;
                        break;
                    case 2:
                        unit.allowEdit = eachObject;
                        break;
                    default:
                        break;
                }
                index ++;
            }
            va_end(arguments);
        }
        return strong;
    };
}


- (SBTextContent* (^)())sbbrline{
    __weak typeof(self) weak = self;
    return ^(){
        __strong typeof(weak) strong = weak;
        SBTextContentBrline *unit = [SBTextContentBrline new];
        unit.index = strong.unitsArray.count;
        [strong.unitsArray addObject:unit];
        return strong;
    };
}

- (SBTextContent* (^)(NSString *url,CGSize size,...))sbimage{
    __weak typeof(self) weak = self;
    return ^(NSString *url,CGSize size,...){
        __strong typeof(weak) strong = weak;
        SBTextContentImage *unit = [SBTextContentImage new];
        unit.index = strong.unitsArray.count;
        [strong.unitsArray addObject:unit];
        unit.url = url;
        unit.size = size;
        va_list arguments;
        id eachObject;
        if (size.height || size.width) {
            va_start(arguments, size);
            int index = 0;
            while ((eachObject = va_arg(arguments, id))) {
                
                switch (index) {
                    case 0:
                        unit.HDurl = eachObject;
                        break;
                    case 1:
                        unit.allowTap = eachObject;
                        break;
                    default:
                        break;
                }
                index ++;
            }
            va_end(arguments);
        }
        return strong;
    };
}

- (SBTextContent* (^)(NSString *url,...))sblink{
    __weak typeof(self) weak = self;
    return ^(NSString *url,...){
        __strong typeof(weak) strong = weak;
        SBTextContentLink *unit = [SBTextContentLink new];
        unit.index = strong.unitsArray.count;
        [strong.unitsArray addObject:unit];
        unit.url = url;
        va_list arguments;
        id eachObject;
        if (url) {
            va_start(arguments, url);
            int index = 0;
            while ((eachObject = va_arg(arguments, id))) {
                
                switch (index) {
                    case 0:
                        unit.color = eachObject;
                        break;
                    case 1:
                        unit.allowTap = eachObject;
                        break;
                    case 2:
                        unit.font = eachObject;
                        break;
                    case 3:
                        unit.highlightFont = eachObject;
                        break;
                    case 4:
                        unit.highlightColor = eachObject;
                        break;
                    default:
                        break;
                }
                index ++;
            }
            va_end(arguments);
        }
        return strong;
    };
}
- (SBTextContent* (^)())sbparagraph{
    __weak typeof(self) weak = self;
    return ^(){
        __strong typeof(weak) strong = weak;
        SBTextContentParagraph *unit = [SBTextContentParagraph new];
        unit.index = strong.unitsArray.count;
        [strong.unitsArray addObject:unit];
        return strong;
    };
}


@end
