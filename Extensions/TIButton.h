//
//  TIButton.h
//  TreeID
//
//  Created by Noah Blake on 1/29/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIButton : UIButton

@property (nonatomic, copy) NSString *undisplayedTitle;
@property int buttonRow;
@property BOOL hasBeenPressed;


@end
