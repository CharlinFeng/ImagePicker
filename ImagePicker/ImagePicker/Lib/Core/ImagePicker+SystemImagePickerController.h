//
//  ImagePicker+SystemImagePickerController.h
//  ImagePicker
//
//  Created by 冯成林 on 16/2/1.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ImagePicker.h"
#import "ImagePickerProtocol.h"

@interface ImagePicker (SystemImagePickerController)

/** 展示照片选取器：系统 */
+(void)show_Camera_SystemLibary_InVC:(__weak UIViewController<ImagePickerDelegate> *)vc isCameraFront:(BOOL)isCameraFront allowEdit:(BOOL)allowEdit maxSize:(CGSize)maxSize maxKB:(CGFloat)maxKB;

@end
