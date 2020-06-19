//
//  InitialViewcontroller.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InitialViewcontroller.h"
#import "SquareView.h"
#import "CircleView.h"
#import "TriangleView.h"

@interface InitialViewcontroller ()

@property (nonatomic, strong) SquareView *squareView;
@property (nonatomic, strong) TriangleView *triangleView;
@property (nonatomic, strong) CircleView *circleView;
@property (nonatomic, strong) UIStackView *pipeStack;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation InitialViewcontroller

- (SquareView *)squareView {
    if(!_squareView) {
        _squareView = [SquareView new];
        _squareView.translatesAutoresizingMaskIntoConstraints = NO;
        [_squareView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_squareView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _squareView;
}

- (TriangleView *)triangleView {
    if(!_triangleView) {
        _triangleView = [TriangleView new];
        _triangleView.translatesAutoresizingMaskIntoConstraints = NO;
        _triangleView.backgroundColor = UIColor.clearColor;
        [_triangleView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_triangleView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _triangleView;
}

- (CircleView *)circleView {
    if(!_circleView) {
        _circleView = [CircleView new];
        _circleView.translatesAutoresizingMaskIntoConstraints = NO;
        _circleView.backgroundColor = UIColor.clearColor;
        [_circleView.heightAnchor constraintEqualToConstant:70].active = YES;
        [_circleView.widthAnchor constraintEqualToConstant:70].active = YES;
    }
    return _circleView;
}

- (UIStackView *)pipeStack {
    if(!_pipeStack) {
        _pipeStack = [UIStackView new];
        _pipeStack.translatesAutoresizingMaskIntoConstraints = NO;
        _pipeStack.axis = UILayoutConstraintAxisHorizontal;
        _pipeStack.distribution = UIStackViewDistributionEqualSpacing;
//        _pipeStack.alignment = UIStackViewAlignmentCenter;
//        _pipeStack.spacing = 2;
    }
    return _pipeStack;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

- (UIButton *)startButton {
    if(!_startButton) {
        _startButton = [UIButton new];
        _startButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_startButton.heightAnchor constraintEqualToConstant:55].active = YES;
        _startButton.layer.cornerRadius = 30;
        _startButton.backgroundColor = [UIColor colorNamed:@"Yellow"];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        
    }
    return _startButton;
}

#pragma mark Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.titleLabel];
    self.titleLabel.text = @"Are you ready?";
    [self.view addSubview:self.pipeStack];
    
    [self.view addSubview:self.startButton];
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    [self.startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(buttonPressend:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pipeStack.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor constant:30],
        [self.pipeStack.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:80],
        [self.pipeStack.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor constant:-30],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:80],
        
        [self.startButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor constant:30],
        [self.startButton.topAnchor constraintEqualToAnchor:self.pipeStack.bottomAnchor constant:130],
        [self.startButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor constant:-30],
    ]];
    
    [self.pipeStack addArrangedSubview:self.circleView];
    [self.pipeStack addArrangedSubview:self.squareView];
    [self.pipeStack addArrangedSubview:self.triangleView];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    CABasicAnimation *triangleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    triangleAnimation.fromValue = @(0.0);
    triangleAnimation.toValue = @(M_PI*2);
    triangleAnimation.duration = 5.0f;
    triangleAnimation.repeatCount = INFINITY;
    [self.triangleView.layer addAnimation:triangleAnimation forKey:nil];
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circleAnimation.fromValue = @(0.9);
    circleAnimation.toValue = @(1.1);
    circleAnimation.duration = 0.5f;
    circleAnimation.autoreverses = YES;
    circleAnimation.repeatCount = INFINITY;
    [self.circleView.layer addAnimation:circleAnimation forKey:nil];
    
    
    CABasicAnimation *squareAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    squareAnimation.fromValue = @(-self.squareView.frame.size.width*0.1);
    squareAnimation.toValue = @(self.squareView.frame.size.width*0.1);
    squareAnimation.duration = 1.0f;
    squareAnimation.autoreverses = YES;
    squareAnimation.repeatCount = INFINITY;
    [self.squareView.layer addAnimation:squareAnimation forKey:nil];
}

- (void)buttonPressend:(UIButton *)sender {
    [sender setBackgroundColor: [UIColor colorNamed:@"YellowHighlighted"]];
}

@end
