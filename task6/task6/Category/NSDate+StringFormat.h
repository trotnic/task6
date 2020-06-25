//
//  NSDate+StringFormat.h
//  task6
//
//  Created by Uladzislau on 6/25/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (StringFormat)

- (NSString *)withFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
