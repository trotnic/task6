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

@interface InfoCollectionController ()

@property (nonatomic, strong) PHFetchResult* fetchResult;

@end

@implementation InfoCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorNamed:@"White"];
    
    self.navigationItem.title = @"Info";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorNamed:@"Yellow"];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[InfoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized: {
                PHFetchOptions *options = [PHFetchOptions new];
                options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES]];
                self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
//                NSLog(@"%@", self.fetchResult);
//                [self.fetchResult enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    NSArray *resources = [PHAssetResource assetResourcesForAsset:obj];
//                    NSLog(@"%@", resources);
////                    switch (obj.mediaType) {
////                        case PHAssetMediaTypeImage:
////                            NSLog(@"Image");
////                            break;
////                        case PHAssetMediaTypeVideo:
////                            NSLog(@"Video");
////                            break;
////                        default:
////                            break;
////                    }
////                    obj.
////                    NSLog(@"%@", obj.mediaType);
//                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
                
                break;
            }
            default:
                break;
        }
    }];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
//    NSLog(@"%@", [self.fetchResult[indexPath.item] namePrefix]);
    
//    UILabel *label = [UILabel new];
//    [PHAssetResourceManager.defaultManager requestDataForAssetResource:self.fetchResult[indexPath.item] options:nil dataReceivedHandler:^(NSData * _Nonnull data) {
//        NSLog(@"%@", data);
//    } completionHandler:^(NSError * _Nullable error) {
//
//    }];
//    label.text =
//    cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.05 animations:^{
        [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor colorNamed:@"YellowHighlighted"];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.2 animations:^{
        [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor colorNamed:@"White"];
    }];
}

#pragma mark FlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
