//
//  UIImage+Zip.h
//  ImagePicker
//
//  Created by 冯成林 on 16/1/31.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Zip)

-(UIImage *)zipImageScaledToNewSize:(CGSize)newSize;

-(NSData *)zipWithMaxKB:(CGFloat)maxKB;

-(void)zipWithMaxKB:(CGFloat)maxKB completeBlock:(void(^)(NSData *data))completeBlock;



@end
