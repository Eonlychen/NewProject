//
//  UIButton+Extension.m
//  NewProduct
//
//  Created by guxiangyun on 2018/7/20.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

@implementation UIButton (Extension)

static char buttonRuntimeTag;

- (void)addTouchUpInsideAction:(ButtonBlock)buttonBlock {
    objc_setAssociatedObject(self, &buttonRuntimeTag, buttonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)sender {
    ButtonBlock block = objc_getAssociatedObject(self, &buttonRuntimeTag);
    if (block) {
        block(sender);
    }
}
@end
