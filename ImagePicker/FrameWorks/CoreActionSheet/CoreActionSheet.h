//
//  CoreActionSheet.h
//  CoreActionSheet
//
//  Created by 冯成林 on 16/1/15.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "LCActionSheet.h"

@interface CoreActionSheet : LCActionSheet

+ (void)showActionSheetWithTitle:(NSString *)title
                  buttonTitles:(NSArray *)buttonTitles
                redButtonIndex:(NSInteger)redButtonIndex
                         clicked:(LCActionSheetBlock)clicked;

@end
