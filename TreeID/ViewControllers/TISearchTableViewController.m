//
//  TISearchTableViewController.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TISearchTableViewController.h"
#import "TITreeArray.h"
#import "TIButton.h"
#import "TIWikiHandler.h"
#import "TISingletonObjectWithArray.h"



@interface TISearchTableViewController ()
{
    UIView *_favoriteView;
    UISearchDisplayController *_searchDisplayController;
}
@end

@implementation TISearchTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Search";
        self.tableView.delegate = self;
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setTreeArray: [TITreeArray treeArray]];
    self.filteredTreeArray = [NSMutableArray arrayWithCapacity: self.treeArray.count];
    
    UISearchBar *tmpSearchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    tmpSearchBar.delegate = self;
    self.tableView.tableHeaderView = tmpSearchBar;
    
    
    //gives the tableViewController a search display controller and thereby access to the the delegate methods that relate to filtering the tableView
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:tmpSearchBar contentsController: self];
    [tmpSearchBar release];
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
    
    //if a search is happening, hold the results of that search
    
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive: self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex: self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText: _savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
}

- (void)viewDidUnload
{
	self.filteredTreeArray = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[_treeArray release];
	[_filteredTreeArray release];
    [_searchDisplayController release];
	
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return self.filteredTreeArray.count;
    }
	else
	{
        return self.treeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	while (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
	}
    
    
#pragma mark Favorite button
    
    
    TIButton *tmpFavoriteButton = [TIButton buttonWithType:UIButtonTypeCustom];
    [tmpFavoriteButton setFrame:CGRectMake(0, 0, 30, 30)];
    [tmpFavoriteButton setBackgroundColor: [UIColor redColor]];
    [tmpFavoriteButton setTitle: @"FAV" forState: UIControlStateNormal];
    tmpFavoriteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    tmpFavoriteButton.undisplayedTitle = [_treeArray objectAtIndex: indexPath.row];
    tmpFavoriteButton.buttonRow = indexPath.row;
    [tmpFavoriteButton addTarget: self action:@selector(addFavorite:) forControlEvents: UIControlEventTouchUpInside];
   
    //cell text comes from filtered array when searchDisplayController is active
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
         //alter the button if its been pressed in tableView. This fixes an earlier bug, wherein the searchDisplayController's buttons wouldn't reflect whether they had or hadn't been pressed in the UITableView.
        cell.textLabel.text = [self.filteredTreeArray objectAtIndex: indexPath.row];
        [self setSearchResultButton: tmpFavoriteButton toCorrectStateForRow: cell.textLabel.text];
        cell.accessoryView = tmpFavoriteButton;
    }
    
    //cell text comes from unfiltered tree array if searchDisplayController isn't active
	else
	{
        [self testForDuplicity: tmpFavoriteButton];
        cell.textLabel.text = [self.treeArray objectAtIndex:indexPath.row];
        cell.accessoryView = tmpFavoriteButton;
    }
    
    return cell;
    
}
/* The older, clumsier way the button would behave when pressed. 
 
- (void) askToAddFavorite: (TIButton *) sender
{
    //remove a subview if you have more subviews than trees (if two favorite buttons are clicked consecutively, remove one)
    NSArray *tmpArray = self.view.subviews;
    //11 is the number of views stored by a tableview at a time, +2 if you're searching, +1 if you've come back from a search (a problem with this logic that I decided to leave alone)
    DLog(@"Number of subviews: %i", tmpArray.count);
    if ( (tmpArray.count > 13) || ((tmpArray.count > 11) && (!self.searchDisplayController.isActive)) )
    {
        DLog(@"removed a subview");
        [_favoriteView removeFromSuperview];
        [_favoriteView release];
    }
    
    //pop up view to confirm add favorite
    int tmpViewHeight = 90;
    int tmpViewWidth = 100;
    
    int yPosition = (sender.buttonRow * self.tableView.rowHeight) + (self.tableView.rowHeight / 2)  - (tmpViewHeight / 2);
    int marginBetweenButtons = 10;
    _favoriteView = [[UIView alloc] initWithFrame: CGRectMake(200, yPosition, tmpViewWidth, tmpViewHeight)];
    [_favoriteView setBackgroundColor: [UIColor blackColor]];
    
    
    //confirm button
    TIButton *tmpConfirmButton = [TIButton buttonWithType:UIButtonTypeCustom];
    int buttonHeight = (tmpViewHeight - 3 * marginBetweenButtons) / 2;
    [tmpConfirmButton setFrame: CGRectMake(5, marginBetweenButtons, tmpViewWidth - 10, buttonHeight)];
    [tmpConfirmButton addTarget: _favoriteView action:@selector(removeFromSuperview) forControlEvents: UIControlEventTouchUpInside];
    
    [tmpConfirmButton setBackgroundColor: [UIColor redColor]];
    [tmpConfirmButton setTitle: @"Confirm" forState: UIControlStateNormal];
    tmpConfirmButton.titleLabel.font  = [UIFont systemFontOfSize: 12.0];
    //tmpConfirmButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //pass the title of the relevant cell along
    tmpConfirmButton.undisplayedTitle = [_treeArray objectAtIndex: sender.buttonRow];
    
    [tmpConfirmButton addTarget: self action:@selector(addFavorite:) forControlEvents: UIControlEventTouchUpInside];
    
    
    
    //cancel favorite
    UIButton *tmpCancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [tmpCancelButton setTitle: @"Cancel" forState: UIControlStateNormal];
    
    //useless method, captures the font of the view before it was resized (previously) in comment above
    //tmpCancelButton.titleLabel.font = [UIFont systemFontOfSize: tmpConfirmButton.titleLabel.font.pointSize];
    tmpCancelButton.titleLabel.font  = [UIFont systemFontOfSize: 12.0];
    [tmpCancelButton setBackgroundColor: [UIColor redColor]];
    [tmpCancelButton setFrame: CGRectMake(5, marginBetweenButtons * 2 + tmpConfirmButton.frame.size.height, tmpViewWidth - 10, buttonHeight)];
    [tmpCancelButton addTarget: _favoriteView action:@selector(removeFromSuperview) forControlEvents: UIControlEventTouchUpInside];
    
    
    [self.view addSubview: _favoriteView];
    [_favoriteView addSubview: tmpConfirmButton];
    [_favoriteView addSubview: tmpCancelButton];
}
*/



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DLog(@"Is search display active: %c", self.searchDisplayController.isActive);
    
    //wikiHandler converts the string from the array into a URL that is then used to push a view controller containing a webview
    if (self.searchDisplayController.isActive)
	{
        [TIWikiHandler stringToURL: [_filteredTreeArray objectAtIndex: indexPath.row] andPushFor: self];
    }
    
	else
	{
        [TIWikiHandler stringToURL: [_treeArray objectAtIndex: indexPath.row] andPushFor: self];
    }
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	[self.filteredTreeArray removeAllObjects];
    self.searchWasActive = YES;
    
    //tmpString steps through the treeArray. If it a piece of it (determined by the size of the search text) matches the search text, it is added to the filteredTreeArray, which is what fills the searchDisplayController tableView.
    for(NSString *tmpString in _treeArray)
    {
        NSComparisonResult result = [tmpString compare: searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchText.length)];
        if (result == NSOrderedSame)
        {
            [self.filteredTreeArray addObject: tmpString];
        }
    }
	
}

//these methods reload the table in response to searching

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //since the objects currently have no categorical organization (no scope), these functions aren't doing anything. 
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
}

@end
