//
//  UIImageView+AssetFetch.h
//  task6
//
//  Created by Uladzislau on 6/21/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AssetFetch)

- (void)fetchImageWithAsset:(PHAsset *)asset contentMode:(PHImageContentMode)contentMode targetSize:(CGSize)targetSize;

@end

NS_ASSUME_NONNULL_END
