//
//  NSObject+Dealloc.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TLDeallocBlock)(void);

@interface NSObject (Dealloc)

- (void)addDeallocTask:(TLDeallocBlock)deallocTask forTarget:(id)target key:(NSString *)key;

- (void)removeDeallocTaskForTarget:(id)target key:(NSString *)key;

@end
