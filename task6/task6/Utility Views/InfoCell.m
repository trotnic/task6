//
//  InfoCell.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InfoCell.h"
#import "UIImageView+AssetFetch.h"
#import "PHAsset+StringType.h"

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

#pragma mark - Utility

- (void)setupView {
    [self addSubview:self.imageView];
    [self addSubview:self.descriptionStack];
    [self.descriptionStack addArrangedSubview:self.nameLabel];
    [self.descriptionStack addArrangedSubview:self.subInfoStack];
    [self.subInfoStack addArrangedSubview:self.typeImageView];
    [self.subInfoStack addArrangedSubview:self.propertyLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
        [self.imageView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor],
        [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor],
        
        [self.descriptionStack.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:self.bounds.size.height*0.2],
        [self.descriptionStack.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor],
        [self.descriptionStack.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor],
        [self.descriptionStack.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor]
    ]];
    
    self.layoutMargins = UIEdgeInsetsMake(1, 8, 1, 8);
}

- (void)configureWithAsset:(PHAsset *)asset {
    PHAssetResource *resource = ((PHAssetResource *)[PHAssetResource assetResourcesForAsset:asset].firstObject);
    self.nameLabel.text = resource.originalFilename;
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage:
            self.typeImageView.image = [[UIImage imageNamed:@"image"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.propertyLabel.text = [NSString stringWithFormat:@" %lux%lu", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight];
            [self.imageView fetchImageWithAsset:asset
                                    contentMode:PHImageContentModeAspectFill
                                     targetSize:self.frame.size
                                   deliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic
                              completionHandler:nil];
            break;
        case PHAssetMediaTypeVideo: {
            self.typeImageView.image = [[UIImage imageNamed:@"video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.propertyLabel.text = [NSString stringWithFormat:@" %lux%lu %@", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight, [asset stringDuration]];
            [self.imageView fetchImageWithAsset:asset
                                    contentMode:PHImageContentModeAspectFill
                                     targetSize:self.frame.size
                                   deliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic
                              completionHandler:nil];
            break;
        }
        case PHAssetMediaTypeAudio: {
            self.typeImageView.image = [[UIImage imageNamed:@"audio"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.propertyLabel.text = [NSString stringWithFormat:@" %@", [asset stringDuration]];
            break;
        }
        default:
            self.typeImageView.image = [[UIImage imageNamed:@"nosign"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            break;
    }
}

#pragma mark - Getters

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    }
    return _nameLabel;
}

- (UIStackView *)descriptionStack {
    if(!_descriptionStack) {
        _descriptionStack = [UIStackView new];
        _descriptionStack.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionStack.distribution = UIStackViewDistributionFillEqually;
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
        [_typeImageView.heightAnchor constraintEqualToConstant:20.0f].active = YES;
        [_typeImageView.widthAnchor constraintEqualToConstant:20.0f].active = YES;
    }
    return _typeImageView;
}

- (UILabel *)propertyLabel {
    if(!_propertyLabel) {
        _propertyLabel = [UILabel new];
        _propertyLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
    }
    return _propertyLabel;
}

@end
