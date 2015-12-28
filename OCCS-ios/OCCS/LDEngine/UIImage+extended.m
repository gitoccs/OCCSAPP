//
//  UIImage+extended.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/2.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "UIImage+extended.h"

@implementation UIImage(Extended)

- (NSString *)base64String {
    NSData * data = [UIImageJPEGRepresentation(self, 0.8) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [NSString stringWithUTF8String:[data bytes]];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
