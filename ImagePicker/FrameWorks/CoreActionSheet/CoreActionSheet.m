//
//  CoreActionSheet.m
//  CoreActionSheet
//
//  Created by 冯成林 on 16/1/15.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "CoreActionSheet.h"

@implementation CoreActionSheet

+ (void)showActionSheetWithTitle:(NSString *)title
                    buttonTitles:(NSArray *)buttonTitles
                  redButtonIndex:(NSInteger)redButtonIndex
                         clicked:(LCActionSheetBlock)clicked{

    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:title buttonTitles:buttonTitles redButtonIndex:redButtonIndex clicked:clicked];
    
    sheet.textColor = isActionSheetModeNightModel ? [UIColor whiteColor] : [UIColor blackColor];
    sheet.lineColor = isActionSheetModeNightModel ? [UIColor colorWithWhite:1 alpha:0.2] : [UIColor colorWithWhite:0 alpha:0.25];
    sheet.separaterColor = isActionSheetModeNightModel ? [UIColor colorWithWhite:0.4 alpha:0.2] : [UIColor colorWithWhite:0.6 alpha:0.1];
    sheet.titleColor = isActionSheetModeNightModel ? [UIColor whiteColor] : [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [sheet show];
}

@end
