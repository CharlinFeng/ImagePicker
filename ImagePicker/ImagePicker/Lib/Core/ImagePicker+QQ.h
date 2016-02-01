//
//  ImagePicker+QQ.h
//  ImagePicker
//
//  Created by 冯成林 on 16/2/1.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ImagePicker.h"

@interface ImagePicker (QQ)

/** 展示照片选取器：QQ */
+(void)show_QQImagePickerVC_InVC:(__weak UIViewController<ImagePickerDelegate> *)vc isCameraFront:(BOOL)isCameraFront allowEdit:(BOOL)allowEdit maxCount:(NSInteger)maxCount maxSize:(CGSize)maxSize maxKB:(CGFloat)maxKB;


@end
