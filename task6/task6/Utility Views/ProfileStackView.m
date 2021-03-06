//
//  ProfileStackView.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "ProfileStackView.h"

@interface ProfileStackView ()

@property (nonatomic, strong) UIStackView *textStack;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *deviceLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *osLabel;

@end


@implementation ProfileStackView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Utility

- (void)setupView {
    self.axis = UILayoutConstraintAxisHorizontal;
    self.spacing = self.profileImageView.image.size.width / 6;
    
    self.alignment = UIStackViewAlignmentCenter;
    [self addArrangedSubview:self.profileImageView];
    [self addArrangedSubview:self.textStack];
    
    [self.textStack addArrangedSubview:self.deviceLabel];
    [self.textStack addArrangedSubview:self.typeLabel];
    [self.textStack addArrangedSubview:self.osLabel];
}

#pragma mark Getters

- (UIStackView *)textStack {
    if(!_textStack) {
        _textStack = [UIStackView new];
        _textStack.axis = UILayoutConstraintAxisVertical;
        _textStack.distribution = UIStackViewDistributionEqualCentering;
    }
    return _textStack;
}

- (UIImageView *)profileImageView {
    if(!_profileImageView) {
        _profileImageView = [UIImageView new];
        _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
        _profileImageView.image = [UIImage imageNamed:@"apple"];
        
        [_profileImageView.heightAnchor constraintEqualToConstant:100].active = YES;
        [_profileImageView.widthAnchor constraintEqualToConstant:90].active = YES;
    }
    return _profileImageView;
}

- (UILabel *)deviceLabel {
    if(!_deviceLabel) {
        _deviceLabel = [UILabel new];
        _deviceLabel.text = UIDevice.currentDevice.name;
        _deviceLabel.numberOfLines = 0;
        _deviceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _deviceLabel;
}

- (UILabel *)typeLabel {
    if(!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.numberOfLines = 0;
        _typeLabel.text = UIDevice.currentDevice.model;
    }
    return _typeLabel;
}

- (UILabel *)osLabel {
    if(!_osLabel) {
        _osLabel = [UILabel new];
        _osLabel.numberOfLines = 0;
        _osLabel.text = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
    }
    return _osLabel;
}

@end

