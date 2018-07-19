//
//  NSData+Hash.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)

/**
 *  md5
 */
@property (nonatomic, strong, readonly) NSData *md5Data;
/**
 *  sha1
 */
@property (nonatomic, strong, readonly) NSData *sha1Data;
/**
 *  sha256
 */
@property (nonatomic, strong, readonly) NSData *sha256Data;
/**
 *  sha512
 */
@property (nonatomic, strong, readonly) NSData *sha512Data;

/**
 *  md5 NSData
 *
 *  @param key 密钥
 */
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

/**
 *  sha1Data NSData
 *
 *  @param key 密钥
 */
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/**
 *  sha256Data NSData
 *
 *  @param key 密钥
 */
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

/**
 *  sha512Data NSData
 *
 *  @param key 密钥
 */
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

@end
