//
//  ACHourglassTests.m
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACHourglassTests.h"

@implementation ACHourglassTests

- (void)setUp {
    [super setUp];
	self.hourglass = [[ACHourglass alloc] init];
}

- (void)tearDown {
    self.hourglass = nil;
    [super tearDown];
}

- (void)testInit {
	self.hourglass = [[ACHourglass alloc] init];
	STAssertTrue(self.hourglass.defaultTimeInterval == 0, @"default time interval is not zero");
}

- (void)testInitWithTimeInterval {
	self.hourglass = [[ACHourglass alloc] initWithTimeInterval:5];
	STAssertTrue(self.hourglass.defaultTimeInterval == 5, @"designated initiliazer does not initialize default time interval to 5");
}

- (void)testMeetConditionWithDefaultTimeInterval {
	self.hourglass.defaultTimeInterval = 3;
	[self.hourglass meetCondition:@"test"];
	STAssertFalse([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is met while condition is not yet met");
	[self asyncWaitForDelay:1];
	STAssertFalse([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is met while condition is not yet met");
	[self asyncWaitForDelay:3];
	STAssertTrue([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is not met while condition is met");
}

- (void)testMeetConditionWithTimeInterval {
	[self.hourglass meetCondition:@"test"];
	[self.hourglass setTimeInterval:3 forCondition:@"test"];
	STAssertFalse([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is met while condition is not yet met");
	[self asyncWaitForDelay:1];
	STAssertFalse([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is met while condition is not yet met");
	[self asyncWaitForDelay:3];
	STAssertTrue([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is not met while condition is met");
}

- (void)testClearCondition {
	[self.hourglass setTimeInterval:30 forCondition:@"test"];
	[self.hourglass meetCondition:@"test"];
	STAssertFalse([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is met while condition is not yet met");
	[self.hourglass clearCondition:@"test"];
	STAssertTrue([self.hourglass isTimeIntervalElapsedForCondition:@"test"], @"hourglass returns condition is not met while condition is met");
}
@end
