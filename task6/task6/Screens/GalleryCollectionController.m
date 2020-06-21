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


@interface GalleryCollectionController ()

@property (nonatomic, strong) PHFetchResult *fetchResult;
@property(nonatomic , strong) PHImageManager *imageManager;


@end

@implementation GalleryCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor rsschoolWhiteColor];
    self.navigationItem.title = @"Gallery";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized: {
                PHFetchOptions *options = [PHFetchOptions new];
                options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES]];
                self.fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
                
                break;
            }
            default:
                break;
        }
    }];
    
    [self.collectionView registerClass:[GalleryCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%lu", (unsigned long)self.fetchResult.count);
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
    UIImage *image = ((GalleryCell *)[collectionView cellForItemAtIndexPath:indexPath]).image;
    [self presentViewController:[[ModalImageController alloc] initWithImage:image] animated:YES completion:^{}];
}

@end
