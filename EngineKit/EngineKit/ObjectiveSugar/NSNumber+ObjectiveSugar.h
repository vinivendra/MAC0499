//
//  NSNumber+Rubyfy.h
//  Domainchy
//
//  Created by Marin Usalj on 11/15/12.
//  Copyright (c) 2012 supermar.in | @supermarin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (ObjectiveSugar)

- (void)times:(void(^)(void))block;
- (void)timesWithIndex:(void(^)(NSUInteger index))block;

- (void)upto:(int)number do:(void(^)(NSInteger number))block;
- (void)downto:(int)number do:(void(^)(NSInteger number))block;

// Numeric inflections
@property (nonatomic, readonly, copy) NSNumber *seconds;
@property (nonatomic, readonly, copy) NSNumber *minutes;
@property (nonatomic, readonly, copy) NSNumber *hours;
@property (nonatomic, readonly, copy) NSNumber *days;
@property (nonatomic, readonly, copy) NSNumber *weeks;
@property (nonatomic, readonly, copy) NSNumber *fortnights;
@property (nonatomic, readonly, copy) NSNumber *months;
@property (nonatomic, readonly, copy) NSNumber *years;

// There are singular aliases for the above methods
@property (nonatomic, readonly, copy) NSNumber *second;
@property (nonatomic, readonly, copy) NSNumber *minute;
@property (nonatomic, readonly, copy) NSNumber *hour;
@property (nonatomic, readonly, copy) NSNumber *day;
@property (nonatomic, readonly, copy) NSNumber *week;
@property (nonatomic, readonly, copy) NSNumber *fortnight;
@property (nonatomic, readonly, copy) NSNumber *month;
@property (nonatomic, readonly, copy) NSNumber *year;

@property (nonatomic, readonly, copy) NSDate *ago;
- (NSDate *)ago:(NSDate *)time;
- (NSDate *)since:(NSDate *)time;
- (NSDate *)until:(NSDate *)time;
@property (nonatomic, readonly, copy) NSDate *fromNow;

@end
