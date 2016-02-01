//
//  UIImage+Zip.m
//  ImagePicker
//
//  Created by 冯成林 on 16/1/31.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "UIImage+Zip.h"

@implementation UIImage (Zip)

-(UIImage *)zipImageScaledToNewSize:(CGSize)newSize{
    

    
    if(CGSizeEqualToSize(newSize, CGSizeZero)){return self;}
    
    CGSize originalSize = self.size;
    
    if(newSize.width > originalSize.width || newSize.height > originalSize.height) return self;
    
    CGSize contextSize = CGSizeZero;
    
    if(newSize.width > 0 && newSize.height > 0){
    
        CGFloat p_width = originalSize.width / newSize.width;
        CGFloat p_height = originalSize.height / newSize.height;
        CGFloat p_max = MAX(p_width, p_height);
        contextSize = CGSizeMake(originalSize.width / p_max, originalSize.height / p_max);
    }
    
    if(newSize.height > 0){
        
        CGFloat p = originalSize.height / newSize.height;
        
        contextSize = CGSizeMake(originalSize.width / p, originalSize.height / p);
    }
    
    if(newSize.width > 0){ 
        
        CGFloat p = originalSize.width / newSize.width;
        
        contextSize = CGSizeMake(originalSize.width / p, originalSize.height / p);
    }
    
    UIGraphicsBeginImageContext (contextSize);
 
    [self drawInRect : CGRectMake ( 0 , 0 ,contextSize.width ,contextSize.height )];
  
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
}


-(NSData *)zipWithMaxKB:(CGFloat)maxKB{
    
    NSData *imageData = UIImageJPEGRepresentation (self, 1);
    
    CGFloat compression = 1;
    
    CGFloat maxCompression = 0.1f;
    
    int maxFileSize = maxKB * 1024;
    
    NSInteger i = 0;
    CGFloat step = 0.01;
    while ( [ imageData length ] > maxFileSize && compression > maxCompression )
    {
        
        UIImage *image_temp = [UIImage imageWithData:imageData];
        i++;
        compression -= step;
        imageData = UIImageJPEGRepresentation (image_temp, compression);
        
        if (i >= 5) {step = 0.15;}
        if (i >= 10) {step = 0.2;}
        
    }
    
    NSLog(@"共压缩%@次，最终大小%@KB",@(i),@([imageData length]/1024));
    
    return imageData;
}

-(void)zipWithMaxKB:(CGFloat)maxKB completeBlock:(void(^)(NSData *data))completeBlock{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData * imageData = [self zipWithMaxKB:maxKB];

        dispatch_async(dispatch_get_main_queue(), ^{
            if(completeBlock != nil) completeBlock(imageData);
        });
        
    });
}




@end
