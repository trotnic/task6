//
//  InfoCollectionController.m
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "InfoCollectionController.h"
#import "InfoCell.h"
#import <Photos/Photos.h>
#import "UIColor+HEX.h"
#import "SingleItemController.h"

@interface InfoCollectionController ()

@property (nonatomic, strong) PHFetchResult* fetchResult;

@end

@implementation InfoCollectionController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = nil;
    self.collectionView.backgroundColor = [UIColor rsschoolWhiteColor];
    
    self.navigationItem.title = @"Info";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    
    [self.collectionView registerClass:[InfoCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    InfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    [cell configureWithAsset:self.fetchResult[indexPath.item]];
    [cell layoutIfNeeded];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.05 animations:^{
        [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor rsschoolYellowHighlightedColor];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.2 animations:^{
        [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor rsschoolWhiteColor];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[SingleItemController alloc] initWithAsset:self.fetchResult[indexPath.item]] animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 10, 0);
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
