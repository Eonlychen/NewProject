//
//  NSString+Base64.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;
@end
