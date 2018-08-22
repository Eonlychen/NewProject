//
//  TLDeallocTask.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/19.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Dealloc.h"

@interface TLDeallocTask : NSObject

- (void)addTask:(TLDeallocBlock)task forTarget:(id)target key:(NSString *)key;

- (void)removeTaskForTarget:(id)target key:(NSString *)key;

@end
