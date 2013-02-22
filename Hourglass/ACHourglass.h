//
//  ACHourglass.h
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACHourglass : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *conditions;
@property (nonatomic, assign) NSTimeInterval defaultTimeInterval;

/** @name Initialization */

/** Initialize with a default time interval for all conditions
 */
- (id)initWithTimeInterval:(NSTimeInterval)timeInterval;

/** @name Accessing time interval */

/** Get the time interval programmed for a condition
 */
- (NSTimeInterval)timeIntervalForCondition:(NSString*)condition;

/** Set the time interval programmed for a condition
 */
- (void)setTimeInterval:(NSTimeInterval)timeInterval forCondition:(NSString*)condition;

/** @name Check time interval */

/** Check if time interval is elapsed for a given condition
 */
- (BOOL)isTimeIntervalElapsedForCondition:(NSString*)condition;

/** @name Condition */

/** Mark the condition to met now.
 */
- (void)meetCondition:(NSString*)condition;

/** Unmark the condtion.
 */
- (void)clearCondition:(NSString*)condition;

@end
