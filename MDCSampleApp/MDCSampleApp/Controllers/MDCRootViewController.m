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


#import "MDCRootViewController.h"
#import "MDCNetworkActivityManager.h"

@interface MDCRootViewController ()

@end

@implementation MDCRootViewController

#pragma mark - UIViewController Overrides

- (void)viewDidUnload
{
    [label_ release];
    [stepper_ release];
    
    label_ = nil;
    stepper_ = nil;
    
    [super viewDidUnload];
}

#pragma mark - Public Interface

- (IBAction)stepperValueDidChange:(UIStepper *)sender
{
    MDCNetworkActivityManager *nam = [MDCNetworkActivityManager defaultManager];
    double value = [sender value];
    
    // Request indicator if value has incresed, release otherwise.
    stepperValue_ < value ? [nam requestIndicator] : [nam releaseIndicator];
    stepperValue_ = value;
    
    label_.text = [NSString stringWithFormat:@"%.0lf", stepperValue_];
}

@end
