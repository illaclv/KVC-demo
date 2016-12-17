//
//  UIImage+PureColorImage.m
//  KVC
//
//  Created by 隆大佶 on 2016/12/15.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "UIImage+PureColorImage.h"

@implementation UIImage (PureColorImage)
+ (UIImage *)yf_imageWithPureColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *renderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderImage;
}
@end
