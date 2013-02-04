//
//  TITreeForCell.m
//  TreeID
//
//  Created by Noah Blake on 2/4/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITreeForCell.h"
#import "TIButton.h"

@implementation TITreeForCell

- (id) initWithText: (NSString *) inText andButton: (TIButton *) inButton
{
    [self setText: inText];
    [self setButton: inButton];
    return self;
}

-(void) dealloc
{
    [_button release];
    [super dealloc];
}
@end
