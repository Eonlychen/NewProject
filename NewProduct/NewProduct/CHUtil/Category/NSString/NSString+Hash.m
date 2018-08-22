//
//  NSString+Hash.m
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import "NSString+Hash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Hash)

- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

#define FileHashDefaultChunkSizeForReadingData 1024*8
-(NSString*)md5File
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)self, FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}


- (NSString *)sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}
- (NSString *)sha224String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA224(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)sha384String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA384(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}
- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
    
}
- (NSString *)hmacSHA224StringWithKey:(NSString *)key{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}
- (NSString *)hmacSHA256StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
    
}
- (NSString *)hmacSHA384StringWithKey:(NSString *)key{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}
- (NSString *)hmacSHA512StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
    
}
#pragma mark - Helpers
- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

@end
