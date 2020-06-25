//
//  HomeController.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "HomeController.h"
#import "ProfileStackView.h"
#import "FiguresStackView.h"
#import "UIColor+HEX.h"


@interface HomeController ()

@property (nonatomic, strong) UIStackView *verticalStack;
@property (nonatomic, strong) ProfileStackView *profileStackView;
@property (nonatomic, strong) FiguresStackView *figuresStackView;
@property (nonatomic, strong) UIButton *cvButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIStackView *buttonsStack;
@property (nonatomic, strong) UIView *dividerView1;
@property (nonatomic, strong) UIView *dividerView2;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HomeController

#pragma mark - Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSSchool Task 6";
    
    
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.verticalStack];
    
    [self.verticalStack addArrangedSubview:self.profileStackView];
    [self.verticalStack addArrangedSubview:self.dividerView1];
    [self.verticalStack addArrangedSubview:self.figuresStackView];
    [self.verticalStack addArrangedSubview:self.dividerView2];
    
    [self.buttonsStack addArrangedSubview:self.cvButton];
    [self.buttonsStack addArrangedSubview:self.resumeButton];
    
    [self.verticalStack addArrangedSubview:self.buttonsStack];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.verticalStack.leadingAnchor constraintEqualToAnchor:self.scrollView.layoutMarginsGuide.leadingAnchor],
        [self.verticalStack.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:30.0f],
        [self.verticalStack.trailingAnchor constraintEqualToAnchor:self.scrollView.layoutMarginsGuide.trailingAnchor],
        [self.verticalStack.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-30.0f],
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat insetSize = UIScreen.mainScreen.bounds.size.height / 15;
    self.scrollView.layoutMargins = UIEdgeInsetsMake(8, insetSize, 8, insetSize);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.figuresStackView runAnimation];
}

#pragma mark - Utility

- (void)openCV {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://trotnic.github.io/rsschool-cv/cv"]
                                     options:@{}
                           completionHandler:nil];
}

- (void)backToStart {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:@"initialScreenRequiredNotification"
                                                                                       object:nil]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Lazy getters

- (UIView *)dividerView1 {
    if(!_dividerView1) {
        _dividerView1 = [UIView new];
        [_dividerView1.heightAnchor constraintEqualToConstant:2.0f].active = YES;
        _dividerView1.backgroundColor = [[UIColor rsschoolGrayColor] colorWithAlphaComponent:0.5f];
    }
    return _dividerView1;
}

- (UIView *)dividerView2 {
    if(!_dividerView2) {
        _dividerView2 = [UIView new];
        [_dividerView2.heightAnchor constraintEqualToConstant:2.0f].active = YES;
        _dividerView2.backgroundColor = [[UIColor rsschoolGrayColor] colorWithAlphaComponent:0.5f];
    }
    return _dividerView2;
}

- (UIStackView *)buttonsStack {
    if(!_buttonsStack) {
        _buttonsStack = [UIStackView new];
        _buttonsStack.axis = UILayoutConstraintAxisVertical;
        _buttonsStack.spacing = UIScreen.mainScreen.bounds.size.width / 15;
    }
    return _buttonsStack;
}

- (UIButton *)cvButton {
    if(!_cvButton) {
        _cvButton = [UIButton new];
        [_cvButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
        [_cvButton.heightAnchor constraintEqualToConstant:55.0].active = YES;
        _cvButton.layer.cornerRadius = 30.0f;
        _cvButton.titleLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
        _cvButton.backgroundColor = [UIColor rsschoolYellowColor];
        [_cvButton setTitleColor:[UIColor rsschoolBlackColor] forState:UIControlStateNormal];
        
        [_cvButton addTarget:self action:@selector(openCV) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cvButton;
}

- (UIButton *)resumeButton {
    if(!_resumeButton) {
        _resumeButton = [UIButton new];
        [_resumeButton setTitle:@"Go to start!" forState:UIControlStateNormal];
        [_resumeButton.heightAnchor constraintEqualToConstant:55.0].active = YES;
        _resumeButton.layer.cornerRadius = 30.0f;
        _resumeButton.titleLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
        _resumeButton.backgroundColor = [UIColor rsschoolRedColor];
        [_resumeButton setTitleColor:[UIColor rsschoolWhiteColor] forState:UIControlStateNormal];
        
        [_resumeButton addTarget:self action:@selector(backToStart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resumeButton;
}

- (UIStackView *)verticalStack {
    if(!_verticalStack) {
        _verticalStack = [UIStackView new];
        _verticalStack.translatesAutoresizingMaskIntoConstraints = NO;
        _verticalStack.axis = UILayoutConstraintAxisVertical;
        _verticalStack.spacing = 40;
    }
    return _verticalStack;
}

- (ProfileStackView *)profileStackView {
    if(!_profileStackView) {
        _profileStackView = [ProfileStackView new];
    }
    return _profileStackView;
}

- (FiguresStackView *)figuresStackView {
    if(!_figuresStackView) {
        _figuresStackView = [FiguresStackView new];
        
    }
    return _figuresStackView;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
