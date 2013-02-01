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
    TIButton *_shareButton;
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
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
	}
    
    if (emptyFlag == YES)
    {
        cell.textLabel.text = @"Add some favorites!";
        DLog(@"table is empty");
        DLog(@"Title of shareButton: %@", _shareButton.undisplayedTitle);
        //clear button from accessory 
        UIView *tmpView = [[UIView alloc] init];
        cell.accessoryView = tmpView;
        [tmpView release];
    }
    
    else if (indexPath.row < FAVORITEARRAY.count)
    {
        cell.textLabel.text = [FAVORITEARRAY objectAtIndex: indexPath.row];
#pragma mark Share button
        _shareButton = [TIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setFrame:CGRectMake(0, 0, 30, 30)];
        [_shareButton setBackgroundColor: [UIColor  darkGrayColor]];
        [_shareButton setTitle: @"Share" forState: UIControlStateNormal];
        _shareButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _shareButton.buttonRow = indexPath.row;
        _shareButton.undisplayedTitle = [FAVORITEARRAY objectAtIndex: indexPath.row];
        [_shareButton addTarget: self action:@selector(shareThisTree:) forControlEvents: UIControlEventTouchUpInside];
        cell.accessoryView = _shareButton;
    }
    return cell;
}

- (void) shareThisTree: (TIButton *) sender
{
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
    //make the array refresh itself
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (emptyFlag == NO)
        [TIWikiHandler stringToURL: [FAVORITEARRAY objectAtIndex: indexPath.row] andPushFor: self];
}


- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle	forRowAtIndexPath: (NSIndexPath *) indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [FAVORITEARRAY removeObjectAtIndex: indexPath.row];
        //meant for this to solve the issue that results when you empty the table of data - no luck
        if (FAVORITEARRAY.count == 0)
        {
            [FAVORITEARRAY addObject: @"Add some favorites!"];
        }
        
        NSArray *indexPaths = [NSArray arrayWithObject: indexPath];
		[tableView deleteRowsAtIndexPaths: indexPaths withRowAnimation: UITableViewRowAnimationFade];
        
      
	}
}

    
- (void) dealloc
{
    [super dealloc];
}
@end
