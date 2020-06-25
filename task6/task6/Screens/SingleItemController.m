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
#import "PHAsset+StringType.h"
#import "NSDate+StringFormat.h"


@interface SingleItemController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *creationLabel;
@property (nonatomic, strong) UILabel *modificationLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIStackView *textStack;
@property (nonatomic, strong) UIButton *activityButton;
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) PHAssetResource *assetResource;
@property (nonatomic, strong) PHAsset *asset;

@end

@implementation SingleItemController

static CGFloat const insetSize = 30.0f;

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
    
    self.navigationItem.title = self.assetResource.originalFilename;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backAction)];
    
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.stackView];
    [self.textStack addArrangedSubview:self.creationLabel];
    [self.textStack addArrangedSubview:self.modificationLabel];
    [self.textStack addArrangedSubview:self.typeLabel];
    [self.scrollView addSubview:self.imageView];
    [self.stackView addArrangedSubview:self.textStack];
    [self.stackView addArrangedSubview:self.activityButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:insetSize / 3],
        [self.imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:insetSize / 3],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-insetSize / 3],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor],
        
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:insetSize / 3],
        [self.stackView.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:insetSize],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-insetSize / 3],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-insetSize],
    ]];
    
    [self.imageView fetchImageWithAsset:self.asset
                            contentMode:PHImageContentModeAspectFit
                             targetSize:PHImageManagerMaximumSize
                           deliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic
                      completionHandler:
     ^{
        CGFloat ratio = self.imageView.image.size.height / self.imageView.image.size.width;
        [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor multiplier:ratio].active = YES;
    }];
}

#pragma mark - Utility

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share {
    switch (self.asset.mediaType) {
        case PHAssetMediaTypeImage: {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = YES;
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.resizeMode = PHImageRequestOptionsResizeModeNone;
            
            [PHImageManager.defaultManager requestImageDataForAsset:self.asset
                                                            options:options
                                                      resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                [self presentActivityWith:imageData];
            }];
            break;
        }
        case PHAssetMediaTypeVideo: {
            [PHCachingImageManager.defaultManager requestAVAssetForVideo:self.asset
                                                                 options:0
                                                           resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                [self presentActivityWith:urlAsset.URL];
            }];
            break;
        }
        default: {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:@"Can't share this :("
                                                                 preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"ok"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void)presentActivityWith:(NSObject *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[data] applicationActivities:@[]];
        
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.sourceRect = CGRectMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2, 0, 0);
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        [self presentViewController:vc animated:YES completion:nil];
    });
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Lazy Getters

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
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

- (UIStackView *)textStack {
    if(!_textStack) {
        _textStack = [UIStackView new];
        _textStack.axis = UILayoutConstraintAxisVertical;
        _textStack.distribution = UIStackViewDistributionFillEqually;
        [_textStack.heightAnchor constraintEqualToConstant:95.0f].active = YES;
    }
    return _textStack;
}

- (UILabel *)creationLabel {
    if(!_creationLabel) {
        _creationLabel = [UILabel new];
        
        NSString *internalString = [NSString stringWithFormat:@"Creation date: %@", [self.asset.creationDate withFormat:@"HH:mm:ss dd.MM.yyyy"]];
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

        NSString *internalString = [NSString stringWithFormat:@"Modification date: %@", [self.asset.modificationDate withFormat:@"HH:mm:ss dd.MM.yyyy"]];
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
        
        NSString *internalString = [NSString stringWithFormat:@"Type: %@", [self.asset stringType]];
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

- (UIStackView *)stackView {
    if(!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 25.0f;
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _stackView;
}

@end
