//
//  ImagePicker.h
//  ImagePicker
//
//  Created by 冯成林 on 16/1/31.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImagePickerSingleton.h"
#import "ImagePickerProtocol.h"
#import "TZImagePickerController.h"

@interface ImagePicker : NSObject
HMSingletonH(ImagePicker)


@property (nonatomic,weak) id<ImagePickerDelegate> delegate;

@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,assign) BOOL allowEdit,isCameraFront;

@property (nonatomic,assign) CGFloat maxKB;

@property (nonatomic,assign) CGSize maxSize;

@property (nonatomic,strong) UIImagePickerController *systemPickerVC;

@property (nonatomic,strong) TZImagePickerController *qqImagePickerVC;


@end
