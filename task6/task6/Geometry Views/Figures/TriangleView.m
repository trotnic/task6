//
//  TriangleView.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor+HEX.h"

@implementation TriangleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    
    [trianglePath moveToPoint:CGPointMake(rect.size.width / 2, 0)];
    [trianglePath addLineToPoint:CGPointMake(0, rect.size.height)];
    [trianglePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [trianglePath closePath];
    UIColor *color = [UIColor rsschoolGreenColor];
    [color setFill];
    
    [trianglePath fill];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [UIColor.clearColor setFill];
    [path fill];
    [path appendPath:trianglePath];
}


@end
