//
//  TISavedTableViewController.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TISavedTableViewController.h"
#import "TITreeArray.h"
#import "TIButton.h"
#import "TIWikiHandler.h"
#import "TISingletonObjectWithArray.h"

@interface TISavedTableViewController ()
{
    BOOL emptyFlag;
}
@end

@implementation TISavedTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Favorites";
        emptyFlag = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLog(@"Rows: %i", FAVORITEARRAY.count);
    if (FAVORITEARRAY.count == 0)
    {
        emptyFlag = YES;
        return 1;
    }
    
    else
    {
        emptyFlag = NO;
        return  FAVORITEARRAY.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	while (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
	}
    
    if (emptyFlag == YES)
    {
        cell.textLabel.text = @"Add some favorites!";
    }
    
    else if (indexPath.row < FAVORITEARRAY.count)
    {
        cell.textLabel.text = [FAVORITEARRAY objectAtIndex: indexPath.row];
    }
    
    /*
#pragma mark Favorite button
    TIButton *tmpFavoriteButton = [TIButton buttonWithType:UIButtonTypeCustom];
    [tmpFavoriteButton setFrame:CGRectMake(0, 0, 30, 30)];
    [tmpFavoriteButton setBackgroundColor: [UIColor redColor]];
    [tmpFavoriteButton setTitle: @"FAV" forState: UIControlStateNormal];
    tmpFavoriteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    tmpFavoriteButton.title = [_treeArray objectAtIndex: indexPath.row];
    [tmpFavoriteButton addTarget: self action:@selector(addFavorite:) forControlEvents: UIControlEventTouchUpInside];
    cell.accessoryView = tmpFavoriteButton;
    */
    return cell;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
    //make the array refresh itself
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (emptyFlag == NO)
        [TIWikiHandler stringToURL: [FAVORITEARRAY objectAtIndex: indexPath.row] andPushFor: self];
}
- (void) dealloc
{
    [super dealloc];
}
@end
