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


@implementation ViewController
{
  NSMutableArray *_clockViews;
}


- (BOOL)prefersStatusBarHidden
{
  return YES;
}

- (void)_addClockView: (BOOL) isLhs
{
  if (!_clockViews) {
    _clockViews = [NSMutableArray array];
  }
  
  ClockView *clockView = [[ClockView alloc] initWithClock:[Clock clock] style:arc4random_uniform(kClockViewStyleDark+1)];
  [_clockViews addObject: clockView];
  [self.view addSubview: clockView];

  clockView.bounds = CGRectMake(0, 0, 132, 132);

  CGRect contentBounds = self.view.bounds;
  CGFloat offset = 150;
  if (isLhs){
      offset *= -1;
  }
  clockView.center = CGPointMake(contentBounds.size.width / 2. + offset, contentBounds.size.height / 2.);

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

    [self _addClockView: YES];
    [self _addClockView: NO];
  
}

@end
