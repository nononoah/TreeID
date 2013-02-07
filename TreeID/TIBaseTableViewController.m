//
//  TIBaseTableViewController.m
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIBaseTableViewController.h"
#import "TIButton.h"
#import "TIWikiHandler.h"
#import "TISingletonObjectWithArray.h"

@interface TIBaseTableViewController ()

@end

@implementation TIBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) addFavorite: (TIButton *) sender
{
    // this function checks to see if the tree has already been added to the singleton. If the tree has, the function flags it to prevent it from being added again. The button is then returned to its original state.
    
    BOOL tmpFlagForArrayAdd = YES;
    
    //do you exist in the singleton? If so, flag to not add.
    for(NSString *tmpString in FAVORITEARRAY)
    {
        NSComparisonResult result = [tmpString compare: sender.undisplayedTitle options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, tmpString.length)];
        if (result == NSOrderedSame)
        {
            tmpFlagForArrayAdd = NO;
        }
    }
    
    //if you remain flagged to add, add to singleton and change the button to reflect this addition.
    if (tmpFlagForArrayAdd)
    {
        [sender setTitle: @"FAV'd" forState: UIControlStateNormal];
        [sender setBackgroundColor: [UIColor blueColor]];
        
        [FAVORITEARRAY addObject: sender.undisplayedTitle];
        DLog (@"Added to singleton, current array count: %i", FAVORITEARRAY.count);
    }
    
    //if the button is being pressed for the nth time, where n is an even number, it is being unfavorited. Return the button to its unpressed state.
    else
    {
        [sender setTitle: @"FAV" forState: UIControlStateNormal];
        [sender setBackgroundColor: [UIColor redColor]];
        [FAVORITEARRAY removeObject: sender.undisplayedTitle];
        DLog (@"Removed from singleton, current array count: %i", FAVORITEARRAY.count);
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated
{
    //[self.tableView reloadData];
}

- (void) testForDuplicity: (TIButton *) sender
{
    for(NSString *tmpString in FAVORITEARRAY)
    {
        NSComparisonResult result = [tmpString compare: sender.undisplayedTitle options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, tmpString.length)];
        //if it's already in the singleton and the button is incorrectly FAV, call it FAV'd and update view
        if ( (result == NSOrderedSame) && ([sender.titleLabel.text isEqualToString: @"FAV"]) )
        {
            [sender setBackgroundColor: [UIColor blueColor]];
            [sender setTitle: @"FAV'd" forState: UIControlStateNormal];
        }
    }
}

- (void) setSearchResultButton: (TIButton *) sender toCorrectStateForRow: (NSString *) inRowText
{
    
    //set button's undisplayed title to match cell's title
    sender.undisplayedTitle = inRowText;
    //once the button's title has been updated, test it to see if its in singleton, and if it's been pressed
    [self testForDuplicity: sender];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
