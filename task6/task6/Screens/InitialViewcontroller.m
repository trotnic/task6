//
//  InitialViewcontroller.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InitialViewcontroller.h"
#import "FiguresStackView.h"
#import "UIColor+HEX.h"

@interface InitialViewcontroller ()

@property (nonatomic, strong) FiguresStackView *pipeStack;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIStackView *mainPipe;

@property (nonatomic, assign) CGFloat insetSize;

@end

@implementation InitialViewcontroller

#pragma mark Getters


- (FiguresStackView *)pipeStack {
    if(!_pipeStack) {
        _pipeStack = [FiguresStackView new];
        _pipeStack.translatesAutoresizingMaskIntoConstraints = NO;
        [_pipeStack.heightAnchor constraintEqualToConstant:70].active = YES;
        _pipeStack.axis = UILayoutConstraintAxisHorizontal;
        _pipeStack.distribution = UIStackViewDistributionEqualSpacing;
    }
    return _pipeStack;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_titleLabel.heightAnchor constraintEqualToConstant:50].active = YES;
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
        _startButton.backgroundColor = [UIColor rsschoolYellowColor];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        
    }
    return _startButton;
}

- (UIStackView *)mainPipe {
    if(!_mainPipe) {
        _mainPipe = [UIStackView new];
        _mainPipe.translatesAutoresizingMaskIntoConstraints = NO;
        _mainPipe.axis = UILayoutConstraintAxisVertical;
        _mainPipe.distribution = UIStackViewDistributionEqualCentering;
    }
    return _mainPipe;
}

- (CGFloat)insetSize {
    if(!_insetSize) {
        _insetSize = [[NSUserDefaults.standardUserDefaults valueForKey:@"sideInset"] floatValue];
    }
    return _insetSize;
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
    
    [self.view addSubview:self.mainPipe];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainPipe.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor constant:self.insetSize],
        [self.mainPipe.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:4*self.insetSize],
        [self.mainPipe.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor constant:-self.insetSize],
        [self.mainPipe.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor constant:-5*self.insetSize]
    ]];
    
    [self.mainPipe addArrangedSubview:self.titleLabel];
    [self.mainPipe addArrangedSubview:self.pipeStack];
    [self.mainPipe addArrangedSubview:self.startButton];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.pipeStack runAnimation];
}

- (void)buttonPressend:(UIButton *)sender {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:@"mainScreenRequiredNotification" object:nil]];
}

@end
