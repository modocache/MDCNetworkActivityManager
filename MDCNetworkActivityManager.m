//
//  Copyright (c) 2012 modocache
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "MDCNetworkActivityManager.h"
#import <libkern/OSAtomic.h>

static MDCNetworkActivityManager *sharedInstance_ = nil;

@interface MDCNetworkActivityManager ()
- (void)toggleIndicator:(NSNumber *)visible;
@end

@implementation MDCNetworkActivityManager

#pragma mark - Object Lifecycle

/// While MDCNetworkActivityManager can be initialzed and released directly,
/// defaultManager should be used in order to access the shared instance.
///
/// @return An instance of MDCNetworkActivityManager meant to be shared
///         among the application.
+ (MDCNetworkActivityManager *)defaultManager
{
    @synchronized(self) {
        if (sharedInstance_ == nil) {
            sharedInstance_ = [[MDCNetworkActivityManager alloc] init];
        }
        return sharedInstance_;
    }
}

#pragma mark - Public Interface

/// Request that network acticity indicator be displayed.
- (void)requestIndicator
{
    if (OSAtomicIncrement32(&counter_) > 0) {
        [self performSelectorOnMainThread:@selector(toggleIndicator:)
                               withObject:[NSNumber numberWithBool:YES]
                            waitUntilDone:NO];
    }
}

/// Indicate that network activity indicator no longer needs
/// to be displayed.
- (void)releaseIndicator
{
    if (OSAtomicDecrement32(&counter_) <= 0) {
        [self performSelectorOnMainThread:@selector(toggleIndicator:)
                               withObject:[NSNumber numberWithBool:NO]
                            waitUntilDone:NO];
    }
}

#pragma mark - Internal Methods

/// Used internally.
- (void)toggleIndicator:(NSNumber *)visible
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = [visible boolValue];
}

@end
