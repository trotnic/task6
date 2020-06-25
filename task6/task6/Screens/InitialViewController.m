//
//  InitialViewcontroller.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InitialViewController.h"
#import "FiguresStackView.h"
#import "UIColor+HEX.h"
#import "Constants.h"

@interface InitialViewController ()

@property (nonatomic, strong) FiguresStackView *figuresStack;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIStackView *mainStack;

@end

@implementation InitialViewController

#pragma mark Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.titleLabel.text = @"Are you ready?";
    
    [self.view addSubview:self.figuresStack];
    [self.view addSubview:self.mainStack];
    [self.mainStack addArrangedSubview:self.titleLabel];
    [self.mainStack addArrangedSubview:self.figuresStack];
    [self.mainStack addArrangedSubview:self.startButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainStack.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [self.mainStack.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        [self.mainStack.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [self.mainStack.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat insetSize = UIScreen.mainScreen.bounds.size.height / 15;
    self.view.layoutMargins = UIEdgeInsetsMake(1.5*insetSize, insetSize, 2.5*insetSize, insetSize);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.figuresStack runAnimation];
}

#pragma mark Getters

- (FiguresStackView *)figuresStack {
    if(!_figuresStack) {
        _figuresStack = [FiguresStackView new];
        _figuresStack.axis = UILayoutConstraintAxisHorizontal;
        _figuresStack.distribution = UIStackViewDistributionEqualSpacing;
    }
    return _figuresStack;
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
        [_startButton.heightAnchor constraintEqualToConstant:55.0f].active = YES;
        _startButton.layer.cornerRadius = 30.0f;
        _startButton.backgroundColor = [UIColor rsschoolYellowColor];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        [_startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor rsschoolGrayColor] forState:UIControlStateHighlighted];
        [_startButton setTitle:@"START" forState:UIControlStateNormal];
        [_startButton addTarget:self
                         action:@selector(buttonPressend:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIStackView *)mainStack {
    if(!_mainStack) {
        _mainStack = [UIStackView new];
        _mainStack.translatesAutoresizingMaskIntoConstraints = NO;
        _mainStack.axis = UILayoutConstraintAxisVertical;
        _mainStack.distribution = UIStackViewDistributionEqualSpacing;
        
    }
    return _mainStack;
}

#pragma mark - Utility

- (void)buttonPressend:(UIButton *)sender {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:MainScreenRequiredNotification
                                                                                       object:nil]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end


