//
//  ACHourglass.m
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACHourglass.h"

static NSString *kCPHourglassTimeIntervalKey = @"kCPHourglassTimeIntervalKey";
static NSString *kCPHourglassLastTimeKey = @"kCPHourglassLastTimeKey";


@interface ACHourglass ()
@property (nonatomic, strong) NSMutableDictionary *conditions;
@end

@implementation ACHourglass

- (id)init {
    return [self initWithTimeInterval:0];
}

- (id)initWithTimeInterval:(NSTimeInterval)timeInterval {
    self = [super init];
    if (self) {
        self.conditions = [[NSMutableDictionary alloc] init];
		self.defaultTimeInterval = timeInterval;
    }
    return self;
}

- (NSTimeInterval)timeIntervalForCondition:(NSString*)condition {
	return [self.conditions[condition] doubleForKey:kCPHourglassTimeIntervalKey];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval forCondition:(NSString*)condition {
	NSMutableDictionary *conditionData = self.conditions[condition];
	if (!conditionData) {
		self.conditions[condition] = conditionData = [[NSMutableDictionary alloc] init];
	}
	conditionData[kCPHourglassTimeIntervalKey] = [NSNumber numberWithDouble:timeInterval];
}

- (BOOL)isTimeIntervalElapsedForCondition:(NSString*)condition {
	NSMutableDictionary *conditionData = self.conditions[condition];
	return (
			!conditionData ||
			!conditionData[kCPHourglassLastTimeKey] ||
			fabs([conditionData[kCPHourglassLastTimeKey] timeIntervalSinceNow]) > [conditionData[kCPHourglassTimeIntervalKey] doubleValue]);
}

- (void)meetCondition:(NSString*)condition {
	NSMutableDictionary *conditionData = self.conditions[condition];
	if (!conditionData) {
		self.conditions[condition] = conditionData = [[NSMutableDictionary alloc] init];
	}
	if (!conditionData[kCPHourglassTimeIntervalKey]) {
		conditionData[kCPHourglassTimeIntervalKey] = [NSNumber numberWithDouble:self.defaultTimeInterval];
	}
	conditionData[kCPHourglassLastTimeKey] = [NSDate date];
}

- (void)clearCondition:(NSString*)condition {
	NSMutableDictionary *conditionData = self.conditions[condition];
	if (conditionData) {
		[conditionData removeObjectForKey:kCPHourglassLastTimeKey];
	}
}

@end

