//
//  PHAsset+StringType.h
//  task6
//
//  Created by Uladzislau on 6/25/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (StringType)

- (NSString *)stringType;
- (NSString *)stringDuration;

@end

NS_ASSUME_NONNULL_END
