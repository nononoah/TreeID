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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
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
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
	}
    
    //put something in the table if the singleton is empty
    if (emptyFlag == YES)
    {
        cell.textLabel.text = @"Add some favorites!";
        DLog(@"table is empty");
        //clear button from accessory if you don't want this being shared. Fixes a bug wherein a share button from a deleted tree would appear next to "Add some favorites"
        UIView *tmpView = [[UIView alloc] init];
        cell.accessoryView = tmpView;
        [tmpView release];
    }
    
    //if singleton has content, go ahead and use this content to fill the tableView
    else if (indexPath.row < FAVORITEARRAY.count)
    {
        cell.textLabel.text = [FAVORITEARRAY objectAtIndex: indexPath.row];
#pragma mark Share button
        TIButton *tmpShareButton = [TIButton buttonWithType:UIButtonTypeCustom];
        [tmpShareButton setFrame:CGRectMake(0, 0, 30, 30)];
        [tmpShareButton setBackgroundColor: [UIColor  darkGrayColor]];
        [tmpShareButton setTitle: @"Share" forState: UIControlStateNormal];
        tmpShareButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        tmpShareButton.buttonRow = indexPath.row;
        tmpShareButton.undisplayedTitle = [FAVORITEARRAY objectAtIndex: indexPath.row];
        [tmpShareButton addTarget: self action:@selector(shareThisTree:) forControlEvents: UIControlEventTouchUpInside];
        cell.accessoryView = tmpShareButton;
    }
    return cell;
}

- (void) shareThisTree: (TIButton *) sender
{
    //create a UIActivityViewController which sends some copy and a wiki link to the tree the user is sharing
    NSMutableString *tmpMutableString = [NSMutableString stringWithString: @"Look at this amazing tree: "];
    NSMutableString *tmpURLString = [NSMutableString stringWithString: [TIWikiHandler stringToURL: sender.undisplayedTitle]];
    [tmpMutableString appendString: tmpURLString];
    
    NSArray *tmpStringArray = [NSArray arrayWithObject: tmpMutableString];
    UIActivityViewController *tmpActivityViewController = [[UIActivityViewController alloc] initWithActivityItems: tmpStringArray applicationActivities: nil];
    [self.navigationController presentViewController: tmpActivityViewController animated:YES completion: NULL];
    [tmpActivityViewController release];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    //make the table view refresh itself in case the singleton has been altered since its last appearance
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //only allow user to push to wikipedia if he's clicking a tree
    if (emptyFlag == NO)
        [TIWikiHandler stringToURL: [FAVORITEARRAY objectAtIndex: indexPath.row] andPushFor: self];
}


- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle	forRowAtIndexPath: (NSIndexPath *) indexPath
{
    //only delete an object from the singleton if the singleton has something to delete 
    if (FAVORITEARRAY.count > 0)
    {
        [FAVORITEARRAY removeObjectAtIndex: indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject: indexPath];
        
        //if after you delete this an object from the singleton, the singleton still contains content to fill a row, go ahead and remove the row
        if ((editingStyle == UITableViewCellEditingStyleDelete) && (FAVORITEARRAY.count != 0))
            [tableView deleteRowsAtIndexPaths: indexPaths withRowAnimation: UITableViewRowAnimationFade];
        
        //if the singleton has nothing left to put in a row, reload the row, which will cause it to revert to the default empty content as emptyFlag goes to YES when numberOfRows is called, then emptyFlag causes default behavior in cellForRowAtIndexPath
        else if ((editingStyle == UITableViewCellEditingStyleDelete) && (FAVORITEARRAY.count == 0))
            [tableView reloadRowsAtIndexPaths: indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void) dealloc
{
    [super dealloc];
}
@end
