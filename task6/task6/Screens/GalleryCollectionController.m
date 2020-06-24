//
//  GalleryCollectionController.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "GalleryCollectionController.h"
#import "GalleryCell.h"
#import <Photos/Photos.h>
#import "ModalImageController.h"
#import "UIColor+HEX.h"
#import <AVKit/AVKit.h>


@interface GalleryCollectionController ()

@property (nonatomic, strong) PHFetchResult *fetchResult;
@property(nonatomic , strong) PHImageManager *imageManager;


@end

@implementation GalleryCollectionController

static NSString * const reuseIdentifier = @"Cell";


#pragma mark - Controller Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor rsschoolWhiteColor];
    self.navigationItem.title = @"Gallery";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    
    [self.collectionView registerClass:[GalleryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized: {
                [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
                [self fetchData];
                
                break;
            }
            default:
                break;
        }
    }];
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell loadAsset:self.fetchResult[indexPath.item]];
    return cell;
}


#pragma mark <UICollectionViewDelegate>


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 4, 4, 4);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.collectionView.frame.size.width - 16) / 3, (self.collectionView.frame.size.width - 16) / 3);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (((PHAsset *) self.fetchResult[indexPath.item]).mediaType) {
        case PHAssetMediaTypeVideo: {
            [PHCachingImageManager.defaultManager requestAVAssetForVideo:self.fetchResult[indexPath.item] options:0 resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    AVPlayer *player = [AVPlayer playerWithURL: urlAsset.URL];
                    AVPlayerViewController *vc = [AVPlayerViewController new];
                    vc.player = player;
                    [self presentViewController:vc animated:YES completion:^{
                        
                    }];
                });
            }];
            break;
        }
        case PHAssetMediaTypeImage: {
            [self presentViewController:[[ModalImageController alloc] initWithAsset:self.fetchResult[indexPath.item]] animated:YES completion:^{}];
            break;
        }
        default: {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Can't show this :(" preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
            [self presentViewController:vc animated:YES completion:^{}];
            break;
        }
    }
}


- (void)fetchData {
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES]];
    
    
    self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - <PHPhotoLibraryChangeObserver>


- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    [self fetchData];
}

@end
