//
//  TISearchTableViewController.h
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//
#import <UIKit/UIKit.h>
@class TITreeArray;

@interface TISearchTableViewController : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) TITreeArray *treeArray;
@property (nonatomic, retain) NSMutableArray *filteredTreeArray;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
