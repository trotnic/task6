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

@interface HomeController ()

@property (nonatomic, strong) UIStackView *verticalStack;
@property (nonatomic, strong) ProfileStackView *profileStackView;
@property (nonatomic, strong) FiguresStackView *figuresStackView;
@property (nonatomic, strong) UIButton *cvButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIStackView *buttonsStack;
@property (nonatomic, strong) UIView *dividerView1;
@property (nonatomic, strong) UIView *dividerView2;

@end

@implementation HomeController

- (UIView *)dividerView1 {
    if(!_dividerView1) {
        _dividerView1 = [UIView new];
        [_dividerView1.heightAnchor constraintEqualToConstant:2.0f].active = YES;
        _dividerView1.backgroundColor = [[UIColor colorNamed:@"Gray"] colorWithAlphaComponent:0.5f];
    }
    return _dividerView1;
}

- (UIView *)dividerView2 {
    if(!_dividerView2) {
        _dividerView2 = [UIView new];
        [_dividerView2.heightAnchor constraintEqualToConstant:2.0f].active = YES;
        _dividerView2.backgroundColor = [[UIColor colorNamed:@"Gray"] colorWithAlphaComponent:0.5f];
    }
    return _dividerView2;
}

- (UIStackView *)buttonsStack {
    if(!_buttonsStack) {
        _buttonsStack = [UIStackView new];
        _buttonsStack.axis = UILayoutConstraintAxisVertical;
        _buttonsStack.spacing = 20.0f;
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
        _cvButton.backgroundColor = [UIColor colorNamed:@"Yellow"];
        [_cvButton setTitleColor:[UIColor colorNamed:@"Black"] forState:UIControlStateNormal];
        
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
        _resumeButton.backgroundColor = [UIColor colorNamed:@"Red"];
        [_resumeButton setTitleColor:[UIColor colorNamed:@"White"] forState:UIControlStateNormal];
        
        [_resumeButton addTarget:self action:@selector(backToStart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resumeButton;
}

- (UIStackView *)verticalStack {
    if(!_verticalStack) {
        _verticalStack = [UIStackView new];
        _verticalStack.translatesAutoresizingMaskIntoConstraints = NO;
        _verticalStack.axis = UILayoutConstraintAxisVertical;
        _verticalStack.distribution = UIStackViewDistributionEqualCentering;
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

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSSchool Task 6";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorNamed:@"Yellow"];
    
    self.view.backgroundColor = [UIColor colorNamed:@"White"];
    
    [self.view addSubview:self.verticalStack];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.verticalStack.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor constant:UIScreen.mainScreen.bounds.size.width / 12],
        [self.verticalStack.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:UIScreen.mainScreen.bounds.size.width / 12],
        [self.verticalStack.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor constant:-UIScreen.mainScreen.bounds.size.width / 12],
        [self.verticalStack.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor constant:-UIScreen.mainScreen.bounds.size.width / 12]
    ]];
    
    [self.verticalStack addArrangedSubview:self.profileStackView];
    [self.verticalStack addArrangedSubview:self.dividerView1];
    [self.verticalStack addArrangedSubview:self.figuresStackView];
    [self.verticalStack addArrangedSubview:self.dividerView2];
    
    [self.buttonsStack addArrangedSubview:self.cvButton];
    [self.buttonsStack addArrangedSubview:self.resumeButton];
    
    [self.verticalStack addArrangedSubview:self.buttonsStack];
    
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
