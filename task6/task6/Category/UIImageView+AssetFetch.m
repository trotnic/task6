//
//  UIImageView+AssetFetch.m
//  task6
//
//  Created by Uladzislau on 6/21/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "UIImageView+AssetFetch.h"

@implementation UIImageView (AssetFetch)

- (void)fetchImageWithAsset:(PHAsset *)asset contentMode:(PHImageContentMode)contentMode targetSize:(CGSize)targetSize {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.version = PHImageRequestOptionsVersionOriginal;
    [PHImageManager.defaultManager requestImageForAsset:asset targetSize:targetSize contentMode:contentMode options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.image = result;
    }];
}

@end
