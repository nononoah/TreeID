//
//  TICladisticViewController.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TICladisticViewController.h"
#import "TITreeDictionary.h"

@interface TICladisticViewController ()
{
    UIButton *_button;
    NSArray *_buttonArray;
}
@end

@implementation TICladisticViewController

- (id) initWithButtonArray: (NSArray *) inArray
{
    self = [super init];
    if (self)
    {
        _buttonArray = [NSArray arrayWithArray: inArray];
    }
    return self;
}

- (void)viewDidLoad
{
   //uses TIBaseViewController's methods to do everything, viewDidLoad differs primarily to separate first screen from those that follow
    [self setUpButtons: _buttonArray];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [super dealloc];
}


@end
