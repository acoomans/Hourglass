//
//  Hourglass.h
//  Hourglass
//
//  Created by Arnaud Coomans on 21/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Hourglass is a dispatch-like collection of functions to execute code depending on time intervals
 *
 */

typedef void (^hourglassBlock)(void);

/** Set the hourglass for _key_
 */
void hourglass_set(NSString *key);

/** Reset the hourglass for _key_
 */
void hourglass_clear(NSString *key);

/** Check if _timeInterval_ is passed for _key_ in the hourglass
 */
BOOL hourglass_elapsed(NSString *key, NSTimeInterval timeInterval);

/** Check if _timeInterval_ is passed for _key_ in the hourglass,
 * if it is, execute the _elapsed_ block; if not, execute the _notElapsed_ block
 */
void hourglass_run(NSString *key, NSTimeInterval timeInterval, hourglassBlock elapsed, hourglassBlock notElapsed);
