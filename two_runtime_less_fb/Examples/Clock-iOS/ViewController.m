/**
  Copyright (c) 2014-present, Facebook, Inc.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree. An additional grant
  of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ViewController.h"
#import "Clock.h"
#import "ClockView.h"

#define CLOCK_VIEW_MAX_COUNT 10
#define CLOCK_VIEW_TIME_DELAY 3.0

@interface ViewController ()

@end

@implementation ViewController
{
  NSMutableArray *_clockViews;
}


- (BOOL)prefersStatusBarHidden
{
  return YES;
}

- (void)_addClockView
{
  if (!_clockViews) {
    _clockViews = [NSMutableArray array];
  }
  
  ClockView *clockView = [[ClockView alloc] initWithClock:[Clock clock] style:arc4random_uniform(kClockViewStyleDark+1)];
  [_clockViews addObject:clockView];
  [self.view addSubview:clockView];

  clockView.bounds = CGRectMake(0, 0, 132, 132);

  CGRect contentBounds = self.view.bounds;
  clockView.center = CGPointMake(contentBounds.size.width / 2., contentBounds.size.height / 2.);

}



- (void)_removeClockView
{
  if (0 == _clockViews.count) {
    return;
  }

  [_clockViews[0] removeFromSuperview];
  [_clockViews removeObjectAtIndex:0];
}


- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];

    [self _addClockView];
  
}

@end
