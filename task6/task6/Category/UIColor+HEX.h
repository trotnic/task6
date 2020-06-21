//
//  UIColor+HEX.h
//  task6
//
//  Created by Uladzislau on 6/21/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma once

@interface UIColor (HEX)

+(UIColor *)rsschoolBlackColor;
+(UIColor *)rsschoolWhiteColor;
+(UIColor *)rsschoolRedColor;
+(UIColor *)rsschoolBlueColor;
+(UIColor *)rsschoolGreenColor;
+(UIColor *)rsschoolYellowColor;
+(UIColor *)rsschoolGrayColor;
+(UIColor *)rsschoolYellowHighlightedColor;

+ (UIColor *)colorWithHexString:(NSString *) hexString;

@end

