//
//  TITreeForCell.h
//  TreeID
//
//  Created by Noah Blake on 2/4/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TIButton;


@interface TITreeForCell : NSObject
- (id) initWithText: (NSString *) inText andButton: (TIButton *) inButton;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) TIButton *button;


@end
