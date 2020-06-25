//
//  ModalImageController.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "ModalImageController.h"
#import "UIColor+HEX.h"
#import "UIImageView+AssetFetch.h"
#import <AVKit/AVKit.h>

@interface ModalImageController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPanGestureRecognizer* recognizer;

@end

@implementation ModalImageController


- (instancetype)initWithAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}

- (void)closingHandler:(UIPanGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.view];
    CGPoint initialPoint = CGPointZero;
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        initialPoint = touchPoint;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if(touchPoint.y - initialPoint.y > 0) {
            [UIView animateWithDuration:0.3f animations:^{
                self.view.frame = CGRectMake(0, touchPoint.y - initialPoint.y, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    } else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        if(touchPoint.y - initialPoint.y > 50) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }
}

#pragma mark - Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closingHandler:)];
    [self.view addGestureRecognizer:self.recognizer];
    
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    
    
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.scrollView.centerYAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor]
    ]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.completion) {
        self.completion();
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Getters

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageView fetchImageWithAsset:self.asset
                            contentMode:PHImageContentModeAspectFit
                             targetSize:PHImageManagerMaximumSize
                           deliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic
                      completionHandler:nil];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 5.0;
    }
    return _scrollView;
}

#pragma mark - <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
