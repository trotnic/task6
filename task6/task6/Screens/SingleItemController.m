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
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) PHAssetResource *assetResource;

@property (nonatomic, assign) CGFloat insetSize;

@property (nonatomic, strong) NSLayoutConstraint *topImage;
@property (nonatomic, strong) NSLayoutConstraint *trailingImage;
@property (nonatomic, strong) NSLayoutConstraint *bottomImage;
@property (nonatomic, strong) NSLayoutConstraint *leadingImage;

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
    
    self.navigationItem.title = self.assetResource.originalFilename;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textStack];
    [self.contentView addSubview:self.activityButton];
    
    
    
    [self.textStack addArrangedSubview:self.creationLabel];
    [self.textStack addArrangedSubview:self.modificationLabel];
    [self.textStack addArrangedSubview:self.typeLabel];
    
    self.scrollView.contentSize = self.stackView.frame.size;
    self.scrollView.delegate = self;
    
    [self.imageView fetchImageWithAsset:self.asset contentMode:PHImageContentModeAspectFit targetSize:UIScreen.mainScreen.bounds.size];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor],
        
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:self.insetSize / 2],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-self.insetSize / 2],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.textStack.topAnchor constant:-self.insetSize],
        
        [self.textStack.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:self.insetSize / 2],
        [self.textStack.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:self.insetSize],
        [self.textStack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.textStack.bottomAnchor constraintEqualToAnchor:self.activityButton.topAnchor constant:-self.insetSize],
        
        [self.activityButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:self.insetSize],
        [self.activityButton.topAnchor constraintEqualToAnchor:self.textStack.bottomAnchor constant:self.insetSize],
        [self.activityButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-self.insetSize],
        [self.activityButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-self.insetSize]
    ]];

    if (@available(iOS 13.0, *)) {
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    }
    else {
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.scrollView.centerYAnchor].active = YES;
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:self.insetSize/2].active = YES;
    }
}

#pragma mark - <UIScrollViewDelegate>


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
}


#pragma mark - Utility


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


- (void)share {
    switch (self.asset.mediaType) {
        case PHAssetMediaTypeImage: {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = YES;
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.resizeMode = PHImageRequestOptionsResizeModeNone;
            
            [PHImageManager.defaultManager requestImageDataForAsset:self.asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                [self presentActivityWith:imageData];
            }];
            break;
        }
        case PHAssetMediaTypeVideo: {
            [PHCachingImageManager.defaultManager requestAVAssetForVideo:self.asset options:0 resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                [self presentActivityWith:urlAsset.URL];
            }];
            break;
        }
        default: {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Can't share this :(" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
            [self presentViewController:vc animated:YES completion:^{}];
        }
    }
}

- (void)presentActivityWith:(NSObject *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[data] applicationActivities:@[]];
        
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.sourceRect = CGRectMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2, 0, 0);
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        [self presentViewController:vc animated:YES completion:^{}];
    });
}


#pragma mark - Lazy Getters


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
        _textStack.axis = UILayoutConstraintAxisVertical;
        _textStack.distribution = UIStackViewDistributionFillEqually;
        [_textStack.heightAnchor constraintEqualToConstant:95.0f].active = YES;
    }
    return _textStack;
}


- (UILabel *)creationLabel {
    if(!_creationLabel) {
        _creationLabel = [UILabel new];
        
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


- (CGFloat)insetSize {
    if(!_insetSize) {
        _insetSize = [[NSUserDefaults.standardUserDefaults valueForKey:@"sideInset"] floatValue];
    }
    return _insetSize;
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
