//
//  ViewController.m
//  ImplementKVO
//
//  Created by Peng Gu on 2/26/15.
//  Copyright (c) 2015 Peng Gu. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+KVO.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;



@end

@implementation Message

@end



@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textfield;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *label;



@property (nonatomic, strong) Message *message;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeMessage:nil];
    self.message = [[Message alloc] init];
    __weak typeof(self) blockSelf = self;
    [self.message PG_addObserver:self forKey:NSStringFromSelector(@selector(text))
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                            __strong typeof(blockSelf) normalSelf = blockSelf;
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                            NSString * content = (NSString *) newValue;
                            normalSelf.textfield.text = content;
                            normalSelf.label.text = [content uppercaseString];

    }];
    
    [self changeMessage:nil];
}


- (IBAction)changeMessage:(id)sender
{
    NSArray *msgs = @[@"Hello", @"World", @"Objective - C", @"Swift", @"666"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}


- (void)dealloc{
    NSLog(@"666");
   
}

@end
