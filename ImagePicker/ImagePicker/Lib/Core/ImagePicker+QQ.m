//
//  ImagePicker+QQ.m
//  ImagePicker
//
//  Created by 冯成林 on 16/2/1.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ImagePicker+QQ.h"
#import "CoreActionSheet.h"
#import "UIImage+Zip.h"
#import "CoreSVP.h"

@interface ImagePicker ()<UINavigationControllerDelegate, TZImagePickerControllerDelegate>

@end

@implementation ImagePicker (QQ)

/** 展示照片选取器：QQ */
+(void)show_QQImagePickerVC_InVC:(__weak UIViewController<ImagePickerDelegate> *)vc isCameraFront:(BOOL)isCameraFront allowEdit:(BOOL)allowEdit maxCount:(NSInteger)maxCount maxSize:(CGSize)maxSize maxKB:(CGFloat)maxKB{

    ImagePicker *picker = [ImagePicker sharedImagePicker];
    
    //记录
    picker.vc = vc;
    picker.delegate = vc;
    picker.allowEdit = allowEdit;
    picker.isCameraFront = isCameraFront;
    picker.maxKB = maxKB;
    picker.maxSize = maxSize;
    picker.maxCount = maxCount;
    CoreAlertViewCommon(@selector(showWithIndex_QQ:))
}

-(void)showWithIndex_QQ:(NSNumber *)index{

    UIViewController *pickerVC_T = nil;
    
    if(index.integerValue == 0){
    
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if (![UIImagePickerController isSourceTypeAvailable: sourceType]){
            
            if([self.delegate respondsToSelector:@selector(ImagePicker_isSourceTypeAvailable)]){[self.delegate ImagePicker_isSourceTypeAvailable]; return;}
        }
        
        self.systemPickerVC.allowsEditing = self.allowEdit;
        
        self.systemPickerVC.sourceType = sourceType;
        
        self.systemPickerVC.cameraDevice = self.isCameraFront ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
        
        pickerVC_T = self.systemPickerVC;
        
    }else {
    
        TZImagePickerController *pickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        pickerVC.delegate = self;
        pickerVC.maxImagesCount = self.maxCount;
        pickerVC.allowPickingOriginalPhoto = NO;
        pickerVC.allowPickingVideo = NO;
        pickerVC_T = pickerVC;
    }

    [self.vc presentViewController:pickerVC_T animated:YES completion:nil];
}


-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos{
    
    if(![self.delegate respondsToSelector:@selector(ImagePicker_didFinishPickerImages:)]) return;
    
    if(photos == nil || photos.count == 0) return;
    
    NSMutableArray <UIImage *>* images = [NSMutableArray arrayWithCapacity:photos.count];
    
    if(self.maxKB > 0){ //转码
        
        CoreSVPLoading(@"转码中...", NO)
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIImage *sizedImage = [image zipImageScaledToNewSize:self.maxSize];
                
                NSData *data = [sizedImage zipWithMaxKB:self.maxKB];
                
                UIImage *image_zip = [[UIImage alloc] initWithData:data];
                
                [images addObject:image_zip];
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CoreSVP dismiss];
                
                if([self.delegate respondsToSelector:@selector(ImagePicker_didFinishPickerImages:)]){
                    
                    [self.delegate ImagePicker_didFinishPickerImages:images];
                }
            });
        });
        
    }else {
        
        images = [NSMutableArray arrayWithArray:photos];
        
        if([self.delegate respondsToSelector:@selector(ImagePicker_didFinishPickerImages:)]){
        
            [self.delegate ImagePicker_didFinishPickerImages:images];
        }
    }
    

}

@end
