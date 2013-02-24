Hourglass
=========

iOS library for testing if a time interval is elapsed.

## Usage

Execute a block if some 3 seconds elapsed since last time we run the hourglass (or called _hourglass_set_, see below):

    NSString *key = @"my_action";
    hourglass_run(key, 3, ^{
		// do something if more than 3 seconds since last time we did _my_action_
	}, ^{
		// do something if less than 3 seconds since last time we did _my_action_
	});
    
Reset the hourglass:

    hourglass_clear(key);
    
Set manually the hourglass:

    hourglass_set(key);

Check manually if 5 seconds are elapsed:

    BOOL isElapsed = hourglass_elapsed(key, 5);


## Description

There are two different hourglasses:

- _Hourglass_ is a collection of [dispatch](http://developer.apple.com/library/ios/#documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html)-like functions
- _ACHourglass_ is class where you can set a time interval for a named condition and later check if enough time has passed for that condition.

The two are a little bit different and their usage. See documentation and headers for more.

## Documentation

Note: Appledoc only supports classes. SO, unfortunately, the dispatch-like hourglass is not documented by the following procedure.

install appledoc:

`brew install appledoc`

build the _HourglassDocumentation_ target,

the documentation will be automatically added to Xcode.