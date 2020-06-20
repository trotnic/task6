//
//  InfoCell.h
//  task6
//
//  Created by Uladzislau on 6/20/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCell : UICollectionViewCell

- (void)configureWithAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
