//
//  SquareView.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "SquareView.h"
#import "UIColor+HEX.h"

@implementation SquareView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    UIColor *color = [UIColor rsschoolBlueColor];
    [color setFill];
    [path fill];
    
}

 
 
@end
