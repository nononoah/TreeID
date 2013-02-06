//
//  TIBaseTableViewController.h
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TIButton;

@interface TIBaseTableViewController : UITableViewController

- (void) testForDuplicity: (TIButton *) sender;
- (void) setSearchResultButton: (TIButton *) sender toCorrectStateForRow: (NSString *) inRowText;
@end
