//
//  Hourglass.m
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "Hourglass.h"

static NSMutableDictionary *__hourglass_times = nil;

NSMutableDictionary *__hourglass_get_times() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    	__hourglass_times = [[NSMutableDictionary alloc] init];
	});
	return __hourglass_times;
}

BOOL hourglass_elapsed(NSString *key, NSTimeInterval timeInterval) {
	NSMutableDictionary *times = __hourglass_get_times();
	NSDate *time = [times objectForKey:key];
	if ((!time) ||
		(fabs([time timeIntervalSinceNow]) > timeInterval)
		) {
		return YES;
	}
	return NO;
}

void hourglass_set(NSString *key) {
	NSMutableDictionary *times = __hourglass_get_times();
	[times setObject:[NSDate date] forKey:key];
}

void hourglass_clear(NSString *key) {
	NSMutableDictionary *times = __hourglass_get_times();
	[times removeObjectForKey:key];
}

void hourglass_run(NSString *key, NSTimeInterval timeInterval, hourglassBlock elapsed, hourglassBlock notElapsed) {
	if (hourglass_elapsed(key, timeInterval)) {
		if (elapsed) {
			elapsed();
		}
		hourglass_set(key);
	} else {
		if (notElapsed) {
			notElapsed();
		}
	}
}
