//
//  UIButton+Extension.h
//  NewProduct
//
//  Created by guxiangyun on 2018/7/20.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock) (UIButton *sender);

@interface UIButton (Extension)

- (void)addTouchUpInsideAction:(ButtonBlock)buttonBlock;

@end
