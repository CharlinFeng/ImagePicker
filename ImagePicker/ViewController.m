//
//  ViewController.m
//  ImagePicker
//
//  Created by 冯成林 on 16/1/31.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerHeader.h"


@interface ViewController ()<ImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)btnClick:(id)sender {
    
//    [ImagePicker show_Camera_SystemLibary_InVC:self isCameraFront:YES allowEdit:YES maxSize:CGSizeMake(600, 0) maxKB:200];
    [ImagePicker show_QQImagePickerVC_InVC:self isCameraFront:YES allowEdit:NO maxCount:9 maxSize:CGSizeMake(900, 0) maxKB:200];
}

-(void)ImagePicker_didFinishPickerImages:(NSArray<UIImage *> *)images{

    UIImage *image = images.lastObject;
    
//    NSLog(@"分辨率:%@",NSStringFromCGSize(image.size));
    
    self.imageV.image = image;
}


@end
