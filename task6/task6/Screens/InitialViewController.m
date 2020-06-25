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

@interface InitialViewController ()

@property (nonatomic, strong) FiguresStackView *pipeStack;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIStackView *mainPipe;

@end

@implementation InitialViewController

#pragma mark Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.titleLabel.text = @"Are you ready?";
    
    [self.view addSubview:self.pipeStack];
    [self.view addSubview:self.mainPipe];
    [self.mainPipe addArrangedSubview:self.titleLabel];
    [self.mainPipe addArrangedSubview:self.pipeStack];
    [self.mainPipe addArrangedSubview:self.startButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainPipe.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [self.mainPipe.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        [self.mainPipe.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [self.mainPipe.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat insetSize = UIScreen.mainScreen.bounds.size.height / 15;
    self.view.layoutMargins = UIEdgeInsetsMake(1.5*insetSize, insetSize, 2.5*insetSize, insetSize);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.pipeStack runAnimation];
}

#pragma mark Getters

- (FiguresStackView *)pipeStack {
    if(!_pipeStack) {
        _pipeStack = [FiguresStackView new];
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
        _startButton.layer.cornerRadius = 30.0f;
        _startButton.backgroundColor = [UIColor rsschoolYellowColor];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        [_startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_startButton setTitle:@"START" forState:UIControlStateNormal];
        [_startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_startButton addTarget:self
                         action:@selector(buttonPressend:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIStackView *)mainPipe {
    if(!_mainPipe) {
        _mainPipe = [UIStackView new];
        _mainPipe.translatesAutoresizingMaskIntoConstraints = NO;
        _mainPipe.axis = UILayoutConstraintAxisVertical;
        _mainPipe.distribution = UIStackViewDistributionEqualSpacing;
        
    }
    return _mainPipe;
}

#pragma mark - Utility

- (void)buttonPressend:(UIButton *)sender {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:@"mainScreenRequiredNotification"
                                                                                       object:nil]];
}

@end
