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


#import <FBKVOController/FBKVOController.h>


@implementation ViewController
{
  NSMutableArray *_clockViews;
  FBKVOController *_KVOController;
  UILabel * _label;
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
  
    
    //
    
    //
    
    //
    CGRect f = [[UIScreen mainScreen] bounds];
    CGFloat width = 250;
    _label = [[UILabel alloc] initWithFrame: CGRectMake((f.size.width - width)/2 , 100, width, width/2)];
    _label.textColor = UIColor.blueColor;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize: 16];
    _label.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: _label];
    
    //
    
    
    //
    
    //
    
    _KVOController = [FBKVOController controllerWithObserver:self];
    
    // handle clock change, including initial value
    [_KVOController observe:[Clock clock] keyPath:@"date" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(ViewController *  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        // update observer with new value
        NSDate * date = change[NSKeyValueChangeNewKey];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz";
        observer->_label.text = [formatter stringFromDate: date];
    }];
    
    
    
    
    
}

@end
