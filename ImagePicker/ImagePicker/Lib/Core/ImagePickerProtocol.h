//
//  ImagePickerProtocol.h
//  ImagePicker
//
//  Created by 冯成林 on 16/2/1.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#ifndef ImagePickerProtocol_h
#define ImagePickerProtocol_h


@protocol ImagePickerDelegate <NSObject>

/** 该方式不可用 */
-(void)ImagePicker_isSourceTypeAvailable;


/** 选取结束 */
-(void)ImagePicker_didFinishPickerImages:(NSArray <UIImage *>*)images;



@end




#endif

/* ImagePickerProtocol_h */






#define CoreAlertViewCommon(SEL) \
[CoreActionSheet showActionSheetWithTitle:@"请选择一种您选取照片的方式" buttonTitles:@[@"相机拍摄", @"系统相册"] redButtonIndex:0 clicked:^(NSInteger buttonIndex) {\
if(buttonIndex == 2){return;}\
[picker performSelector:SEL withObject:@(buttonIndex)];\
}];
