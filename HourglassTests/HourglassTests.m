//
//  HourglassTests.m
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "HourglassTests.h"

@implementation HourglassTests

- (void)testElapsed {
	NSString *key = @"key";
	hourglass_set(key);
	STAssertFalse(hourglass_elapsed(key, 3), @"hourglass elapsed before time");
	[self asyncWaitForDelay:1];
	STAssertFalse(hourglass_elapsed(key, 3), @"hourglass elapsed before time");
	[self asyncWaitForDelay:3];
	STAssertTrue(hourglass_elapsed(key, 3), @"hourglass isn't elapsed after time");
}

- (void)testClear {
	NSString *key = @"key";
	hourglass_set(key);
	STAssertFalse(hourglass_elapsed(key, 30), @"hourglass elapsed before time");
	hourglass_clear(key);
	STAssertTrue(hourglass_elapsed(key, 30), @"hourglass isn't elapsed after clear");
}

- (void)testDo {
	NSString *key = @"key";
	hourglass_run(key, 3, ^{
		STAssertTrue(true, @"hourglass elapsed before time");
	}, ^{
		STFail(@"hourglass isn't elapsed before time");
	});
	[self asyncWaitForDelay:1];
	hourglass_run(key, 3, ^{
		STFail(@"hourglass elapsed before time");
	}, ^{
		STAssertTrue(true, @"hourglass isn't elapsed before time");
	});
	[self asyncWaitForDelay:3];
	hourglass_run(key, 3, ^{
		STAssertTrue(true, @"hourglass elapsed before time");
	}, ^{
		STFail(@"hourglass isn't elapsed before time");
	});
}

- (void)testDoNil {
	NSString *key = @"key";
	hourglass_run(key, 0, nil, ^{
		STFail(@"hourglass isn't elapsed before time");
	});
	hourglass_run(key, 30, ^{
		STFail(@"hourglass elapsed before time");
	}, nil);
}

@end
