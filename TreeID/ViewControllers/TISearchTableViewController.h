//
//  TISearchTableViewController.h
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//
#import "TIBaseTableViewController.h"
@class TITreeArray;

@interface TISearchTableViewController : TIBaseTableViewController <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSArray *treeArray;
@property (nonatomic, retain) NSMutableArray *filteredTreeArray;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
