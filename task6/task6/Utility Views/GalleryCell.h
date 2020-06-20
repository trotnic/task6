//
//  GalleryCell.h
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImage *image;

- (void)setImage:(UIImage *)image;
- (void)fetchImageWithAsset:(PHAsset *)asset contentMode:(PHImageContentMode)contentMode targetSize:(CGSize)targetSize;
@end

NS_ASSUME_NONNULL_END
