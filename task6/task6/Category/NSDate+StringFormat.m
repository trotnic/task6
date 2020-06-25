//
//  NSDate+StringFormat.m
//  task6
//
//  Created by Uladzislau on 6/25/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "NSDate+StringFormat.h"

@implementation NSDate (StringFormat)

- (NSString *)withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    NSString *result = [formatter stringFromDate:self];
    return result;
}

@end
