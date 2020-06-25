//
//  FiguresStackView.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "FiguresStackView.h"
#import "SquareView.h"
#import "CircleView.h"
#import "TriangleView.h"

static NSString *kSquareAnimation = @"squareTranslation";
static NSString *kCircleAnimation = @"circleFlash";
static NSString *kTriangleAnimation = @"triangleRotation";

@interface FiguresStackView ()

@property (nonatomic, strong) SquareView *squareView;
@property (nonatomic, strong) CircleView *circleView;
@property (nonatomic, strong) TriangleView *triangleView;

@end

@implementation FiguresStackView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark Getters

- (SquareView *)squareView {
    if(!_squareView) {
        _squareView = [SquareView new];
        _squareView.backgroundColor = UIColor.clearColor;
        _squareView.translatesAutoresizingMaskIntoConstraints = NO;
        [_squareView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_squareView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _squareView;
}

- (CircleView *)circleView {
    if(!_circleView) {
        _circleView = [CircleView new];
        _circleView.backgroundColor = UIColor.clearColor;
        _circleView.translatesAutoresizingMaskIntoConstraints = NO;
        [_circleView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_circleView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _circleView;
}

- (TriangleView *)triangleView {
    if(!_triangleView) {
        _triangleView = [TriangleView new];
        _triangleView.backgroundColor = UIColor.clearColor;
        _triangleView.translatesAutoresizingMaskIntoConstraints = NO;
        [_triangleView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_triangleView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _triangleView;
}

#pragma mark - Utility

- (void)setupView {
    [self addArrangedSubview:self.circleView];
    [self addArrangedSubview:self.squareView];
    [self addArrangedSubview:self.triangleView];
    
    
    self.axis = UILayoutConstraintAxisHorizontal;
    self.distribution = UIStackViewDistributionEqualSpacing;
}

- (void)runAnimation {
    CABasicAnimation *triangleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    triangleAnimation.fromValue = @(0.0);
    triangleAnimation.toValue = @(M_PI*2);
    triangleAnimation.duration = 5.0f;
    triangleAnimation.repeatCount = INFINITY;
    triangleAnimation.removedOnCompletion = NO;
    [self.triangleView.layer addAnimation:triangleAnimation forKey:kTriangleAnimation];
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circleAnimation.fromValue = @(0.9);
    circleAnimation.toValue = @(1.1);
    circleAnimation.duration = 0.5f;
    circleAnimation.autoreverses = YES;
    circleAnimation.repeatCount = INFINITY;
    circleAnimation.removedOnCompletion = NO;
    [self.circleView.layer addAnimation:circleAnimation forKey:kCircleAnimation];
    
    
    CABasicAnimation *squareAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    squareAnimation.fromValue = @(-self.squareView.frame.size.width*0.1);
    squareAnimation.toValue = @(self.squareView.frame.size.width*0.1);
    squareAnimation.duration = 1.0f;
    squareAnimation.autoreverses = YES;
    squareAnimation.repeatCount = INFINITY;
    squareAnimation.removedOnCompletion = NO;
    [self.squareView.layer addAnimation:squareAnimation forKey:kSquareAnimation];
}

- (void)stopAnimation {
    [self.triangleView.layer removeAnimationForKey:kTriangleAnimation];
    [self.circleView.layer removeAnimationForKey:kCircleAnimation];
    [self.squareView.layer removeAnimationForKey:kSquareAnimation];
}

@end
