//
//  ImagePicker.m
//  ImagePicker
//
//  Created by 冯成林 on 16/1/31.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ImagePicker.h"


//typedef enum{
//    
//    /** 相机拍摄 */
//    ImagePickerTypeCamera = 0,
//    
//    /** 系统相册 */
//    ImagePickerTypePhotoLibrary,
//    
//    /** 相册多选模式 */
//    ImagePickerTypeMultiPickerModel
//    
//} ImagePickerType;


@interface ImagePicker ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@end

@implementation ImagePicker

HMSingletonM(ImagePicker)




-(UIImagePickerController *)systemPickerVC{

    if(_systemPickerVC == nil){
    
        _systemPickerVC = [[UIImagePickerController alloc] init];
        _systemPickerVC.delegate = self;
    }
    
    return _systemPickerVC;
}




@end
