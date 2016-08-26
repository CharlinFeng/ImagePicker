//
//  ImagePicker+SystemImagePickerController.m
//  ImagePicker
//
//  Created by 冯成林 on 16/2/1.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ImagePicker+SystemImagePickerController.h"
#import "CoreActionSheet.h"
#import "UIImage+Zip.h"
#import "CoreSVP.h"

@implementation ImagePicker (SystemImagePickerController)

/** 展示照片选取器：系统 */
+(void)show_Camera_SystemLibary_InVC:(__weak UIViewController<ImagePickerDelegate> *)vc isCameraFront:(BOOL)isCameraFront allowEdit:(BOOL)allowEdit maxSize:(CGSize)maxSize maxKB:(CGFloat)maxKB{
    
    ImagePicker *picker = [ImagePicker sharedImagePicker];
    
    //记录
    picker.vc = vc;
    picker.delegate = vc;
    picker.allowEdit = allowEdit;
    picker.isCameraFront = isCameraFront;
    picker.maxKB = maxKB;
    picker.maxSize = maxSize;
    CoreAlertViewCommon(@selector(showWithIndex_System:))
    
}


-(void)showWithIndex_System:(NSNumber *)index{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if(index.integerValue == 1) sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (![UIImagePickerController isSourceTypeAvailable: sourceType]){
        CoreSVPError(@"设备不支持", nil)
        if([self.delegate respondsToSelector:@selector(ImagePicker_isSourceTypeAvailable)]){[self.delegate ImagePicker_isSourceTypeAvailable]; return;}
    }
    
    self.systemPickerVC.allowsEditing = self.allowEdit;
    
    self.systemPickerVC.sourceType = sourceType;
    
    if(sourceType == UIImagePickerControllerSourceTypeCamera){self.systemPickerVC.cameraDevice = self.isCameraFront ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;}
    
    [self.vc presentViewController:self.systemPickerVC animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(![self.delegate respondsToSelector:@selector(ImagePicker_didFinishPickerImages:)]) return;
    
    UIImage *image = self.allowEdit ? info[@"UIImagePickerControllerEditedImage"] : info[@"UIImagePickerControllerOriginalImage"];
    
    UIImage *sizedImage = [image zipImageScaledToNewSize:self.maxSize];
    
    if(self.maxKB > 0){
        
        CoreSVPLoading(@"转码中...", NO)
        
        [sizedImage zipWithMaxKB:self.maxKB completeBlock:^(NSData *data) {
            
            [CoreSVP dismiss];
            
            [self.delegate ImagePicker_didFinishPickerImages:@[sizedImage]];
        }];
        
    }else{
        
        [self.delegate ImagePicker_didFinishPickerImages:@[sizedImage]];
    }
}

@end
