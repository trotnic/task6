//
//  CircleView.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+HEX.h"

@implementation CircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width / 2];
    UIColor *color = [UIColor rsschoolRedColor];
    [color setFill];
    [path fill];
    
}


@end
