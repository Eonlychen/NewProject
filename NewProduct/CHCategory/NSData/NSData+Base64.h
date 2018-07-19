//
//  NSData+Base64.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

/**
 *  字符串base64后转data
 *
 *  @param string 传入字符串
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/**
 *  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 */
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

/**
 *  NSData转string 换行长度默认64
 */
- (NSString *)base64EncodedString;

@end
