//
//  GalleryCell.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "GalleryCell.h"
#import "UIImageView+AssetFetch.h"


@interface GalleryCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GalleryCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Utility

- (void)loadAsset:(PHAsset *)asset {
    [self.imageView fetchImageWithAsset:asset
                            contentMode:PHImageContentModeAspectFill
                             targetSize:PHImageManagerMaximumSize
                           deliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic
                      completionHandler:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
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

- (void)setupView {
    [self addSubview:self.imageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    self.imageView.image = [UIImage imageNamed:@"apple"];
}

@end


