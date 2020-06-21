//
//  SingleItemController.m
//  task6
//
//  Created by Uladzislau on 6/21/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "SingleItemController.h"
#import "UIColor+HEX.h"
#import <Photos/Photos.h>
#import "UIImageView+AssetFetch.h"


@interface SingleItemController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *creationLabel;
@property (nonatomic, strong) UILabel *modificationLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIStackView *textStack;
@property (nonatomic, strong) UIButton *activityButton;
@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, strong) PHAssetResource *assetResource;

@end

@implementation SingleItemController

- (instancetype)initWithAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}


#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assetResource = ((PHAssetResource *)[PHAssetResource assetResourcesForAsset:self.asset].firstObject);
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    self.navigationItem.title = self.assetResource.originalFilename;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor rsschoolBlackColor];
    
    
//    NSLog(@"%@ HERE!!!", self.assetResource);
//    NSLog(@"%@", self.asset.cre);
    
    
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.creationLabel];
    [self.contentView addSubview:self.modificationLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.activityButton];
    self.scrollView.delegate = self;
    
    
    
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor],
        
        
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],

        [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.modificationLabel.topAnchor],

        [self.modificationLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.modificationLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.modificationLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor],
        [self.modificationLabel.bottomAnchor constraintEqualToAnchor:self.creationLabel.topAnchor],
//        [self.modificationLabel.heightAnchor constraintEqualToConstant:150.0f],
        
        [self.creationLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.creationLabel.topAnchor constraintEqualToAnchor:self.modificationLabel.bottomAnchor],
        [self.creationLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.creationLabel.bottomAnchor constraintEqualToAnchor:self.typeLabel.topAnchor],
//        [self.creationLabel.heightAnchor constraintEqualToConstant:150.0f],
        
        [self.typeLabel.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        [self.typeLabel.topAnchor constraintEqualToAnchor:self.creationLabel.bottomAnchor],
        [self.typeLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.typeLabel.bottomAnchor constraintEqualToAnchor:self.activityButton.topAnchor],
//        [self.typeLabel.heightAnchor constraintEqualToConstant:150.0f],
        
        [self.activityButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:UIScreen.mainScreen.bounds.size.width / 12],
        [self.activityButton.topAnchor constraintEqualToAnchor:self.typeLabel.bottomAnchor],
        [self.activityButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-UIScreen.mainScreen.bounds.size.width / 12],
        [self.activityButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-UIScreen.mainScreen.bounds.size.width / 12]
//        [self.creationLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
//        [self.textStack.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:20.0f],
//        [self.textStack.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
//        [self.textStack.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor],
//        [self.textStack.bottomAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.bottomAnchor],
////        [self.textStack.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.height / 5]
    ]];
    
    
    [self.imageView fetchImageWithAsset:self.asset contentMode:PHImageContentModeAspectFit targetSize:UIScreen.mainScreen.bounds.size];
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    NSLog(@"%@", [self formattedDate:self.asset.creationDate]);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)formattedDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm:ss dd.MM.yyyy";
    NSString *result = [formatter stringFromDate:date];
    return result;
}

- (NSString *)assetType:(PHAsset *)asset {
    switch (asset.mediaType) {
        case PHAssetMediaTypeAudio:
            return @"Audio";
        case PHAssetMediaTypeImage:
            return @"Image";
        case PHAssetMediaTypeVideo:
            return @"Video";
        default:
            return @"Other";
    }
}

#pragma mark Getters

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    }
    return _scrollView;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (UIStackView *)textStack {
    if(!_textStack) {
        _textStack = [UIStackView new];
        _textStack.translatesAutoresizingMaskIntoConstraints = NO;
        _textStack.alignment = UILayoutConstraintAxisVertical;
        _textStack.distribution = UIStackViewDistributionFillEqually;
    }
    return _textStack;
}

- (UILabel *)creationLabel {
    if(!_creationLabel) {
        _creationLabel = [UILabel new];
        _creationLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
        _creationLabel.textColor = [UIColor rsschoolGrayColor];
        _creationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSString *internalString = [NSString stringWithFormat:@"Creation date: %@", [self formattedDate:self.asset.creationDate]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:internalString attributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolBlackColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        }];
        
        [attributedString setAttributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolGrayColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        } range:[internalString rangeOfString:@"Creation date:"]];
        
        _creationLabel.attributedText = attributedString;
    }
    return _creationLabel;
}

- (UILabel *)modificationLabel {
    if(!_modificationLabel) {
        _modificationLabel = [UILabel new];
//        _modificationLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
//        _modificationLabel.textColor = [UIColor rsschoolGrayColor];
        _modificationLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        _modificationLabel.text = [self formattedDate:self.asset.modificationDate];
        
        NSString *internalString = [NSString stringWithFormat:@"Modification date: %@", [self formattedDate:self.asset.modificationDate]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:internalString attributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolBlackColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        }];
        
        [attributedString setAttributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolGrayColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        } range:[internalString rangeOfString:@"Modification date:"]];
        
        _modificationLabel.attributedText = attributedString;
    }
    return _modificationLabel;
}

- (UILabel *)typeLabel {
    if(!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
        _typeLabel.textColor = [UIColor rsschoolGrayColor];
        _typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _typeLabel.text = [self assetType:self.asset];
        
        NSString *internalString = [NSString stringWithFormat:@"Type: %@", [self assetType:self.asset]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:internalString attributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolBlackColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        }];
        
        [attributedString setAttributes:@{
            NSForegroundColorAttributeName: [UIColor rsschoolGrayColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular]
        } range:[internalString rangeOfString:@"Type:"]];
        
        _typeLabel.attributedText = attributedString;
    }
    return _typeLabel;
}

- (UIButton *)activityButton {
    if(!_activityButton) {
        _activityButton = [UIButton new];
        [_activityButton setTitle:@"Share" forState:UIControlStateNormal];
        _activityButton.titleLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightMedium];
        _activityButton.translatesAutoresizingMaskIntoConstraints = NO;
        _activityButton.layer.cornerRadius = 30.0f;
        [_activityButton.heightAnchor constraintEqualToConstant:55.0f].active = YES;
        [_activityButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        _activityButton.backgroundColor = [UIColor rsschoolYellowColor];
        [_activityButton setTitleColor:[UIColor rsschoolBlackColor] forState:UIControlStateNormal];
    }
    return _activityButton;
}

- (void)share {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image] applicationActivities:@[]];
    [self presentViewController:vc animated:YES completion:^{
        ;
    }];
}


@end
