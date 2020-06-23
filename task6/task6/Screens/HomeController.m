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

@property (nonatomic, assign) CGFloat insetSize;

@end

@implementation HomeController

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
        
        [_cvButton addTarget:self action:@selector(goToCV) forControlEvents:UIControlEventTouchUpInside];
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
//        _verticalStack.distribution = UIStackViewDistributionFill;
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

- (CGFloat)insetSize {
    if(!_insetSize) {
        _insetSize = [[NSUserDefaults.standardUserDefaults valueForKey:@"sideInset"] floatValue];
    }
    return _insetSize;
}

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"RSSchool Task 6";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.verticalStack];
    self.scrollView.contentSize = self.verticalStack.frame.size;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor],
        
        [self.verticalStack.leadingAnchor constraintEqualToAnchor:self.scrollView.layoutMarginsGuide.leadingAnchor constant:self.insetSize],
        [self.verticalStack.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:self.insetSize],
        [self.verticalStack.trailingAnchor constraintEqualToAnchor:self.scrollView.layoutMarginsGuide.trailingAnchor constant:-self.insetSize],
        [self.verticalStack.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-self.insetSize],
    ]];
    
    [self.verticalStack addArrangedSubview:self.profileStackView];
    [self.verticalStack addArrangedSubview:self.dividerView1];
    [self.verticalStack addArrangedSubview:self.figuresStackView];
    [self.verticalStack addArrangedSubview:self.dividerView2];
    
    [self.buttonsStack addArrangedSubview:self.cvButton];
    [self.buttonsStack addArrangedSubview:self.resumeButton];
    
    [self.verticalStack addArrangedSubview:self.buttonsStack];
}

- (void)setMargins {
    if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)) {
        self.view.layoutMargins = UIEdgeInsetsMake(UIScreen.mainScreen.bounds.size.height / 15, UIScreen.mainScreen.bounds.size.height / 5, UIScreen.mainScreen.bounds.size.height / 15, UIScreen.mainScreen.bounds.size.height / 5);
    } else {
        self.view.layoutMargins = UIEdgeInsetsMake(2*UIScreen.mainScreen.bounds.size.width / 15, UIScreen.mainScreen.bounds.size.width / 15, UIScreen.mainScreen.bounds.size.width / 5, UIScreen.mainScreen.bounds.size.width / 15);
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.figuresStackView runAnimation];
}

- (void)goToCV {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://trotnic.github.io/rsschool-cv/cv"] options:@{} completionHandler:^(BOOL success) {
    }];
}

- (void)backToStart {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:@"initialScreenRequiredNotification" object:nil]];
}

@end
