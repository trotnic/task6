//
//  InfoCell.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InfoCell.h"
#import "UIImageView+AssetFetch.h"

@interface InfoCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIStackView *descriptionStack;
@property (nonatomic, strong) UIStackView *subInfoStack;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *propertyLabel;

@end

@implementation InfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_imageView.widthAnchor constraintEqualToConstant:self.bounds.size.width / 5].active = YES;
        [_imageView.heightAnchor constraintEqualToConstant:self.bounds.size.width / 5].active = YES;
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    }
    return _nameLabel;
}

- (UIStackView *)descriptionStack {
    if(!_descriptionStack) {
        _descriptionStack = [UIStackView new];
        _descriptionStack.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionStack.distribution = UIStackViewDistributionEqualCentering;
        _descriptionStack.axis = UILayoutConstraintAxisVertical;
    }
    return _descriptionStack;
}

- (UIStackView *)subInfoStack {
    if(!_subInfoStack) {
        _subInfoStack = [UIStackView new];
        _subInfoStack.axis = UILayoutConstraintAxisHorizontal;

    }
    return _subInfoStack;
}

- (UIImageView *)typeImageView {
    if(!_typeImageView) {
        _typeImageView = [UIImageView new];
        _typeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_typeImageView.widthAnchor constraintEqualToConstant:self.bounds.size.height / 4].active = YES;
        [_typeImageView.heightAnchor constraintEqualToConstant:self.bounds.size.height / 4].active = YES;
    }
    return _typeImageView;
}

- (UILabel *)propertyLabel {
    if(!_propertyLabel) {
        _propertyLabel = [UILabel new];
        _propertyLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
        [_propertyLabel.widthAnchor constraintEqualToConstant:self.bounds.size.width / 3].active = YES;
    }
    return _propertyLabel;
}

- (void)setupView {
    [self addSubview:self.imageView];
    
    
    [self addSubview:self.descriptionStack];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.layoutMarginsGuide.centerYAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:(self.bounds.size.width - 30) / 5],
        [self.imageView.heightAnchor constraintEqualToConstant:(self.bounds.size.width - 30) / 5],
        
        [self.descriptionStack.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:10.0f],
        [self.descriptionStack.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor constant:self.bounds.size.height / 6],
        [self.descriptionStack.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor],
        [self.descriptionStack.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor constant:-self.bounds.size.height / 6]
    ]];
    [self.descriptionStack addArrangedSubview:self.nameLabel];
    [self.descriptionStack addArrangedSubview:self.subInfoStack];
    [self.subInfoStack addArrangedSubview:self.typeImageView];
    [self.subInfoStack addArrangedSubview:self.propertyLabel];
    
    self.layoutMargins = UIEdgeInsetsMake(2, 10, 2, 10);
}

- (void)configureWithAsset:(PHAsset *)asset {
    
    [self.imageView fetchImageWithAsset:asset contentMode:PHImageContentModeAspectFit targetSize:self.bounds.size];
    
    PHAssetResource *resource = ((PHAssetResource *)[PHAssetResource assetResourcesForAsset:asset].firstObject);
    self.nameLabel.text = resource.originalFilename;
    
    self.propertyLabel.text = [NSString stringWithFormat:@"%lux%lu", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight];
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage:
            self.typeImageView.image = [[UIImage imageNamed:@"image"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            break;
            
        case PHAssetMediaTypeVideo:
            self.typeImageView.image = [[UIImage imageNamed:@"video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            break;
        default:
            break;
    }
}



@end
