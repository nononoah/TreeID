//
//  TIApprovedTreesViewController.m
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIApprovedTreesViewController.h"
#import "TITApprovedTreeJSON.h"
#import "TIApprovedTree.h"
#import "TIWikiHandler.h"
#import "TIButton.h"
#import "TISingletonObjectWithArray.h"
#import "TIApprovedTreeView.h"

@interface TIApprovedTreesViewController ()
{
    NSMutableArray *_arrayOfApprovedTreeObjects;
}
@end

@implementation TIApprovedTreesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Search";
        self.tableView.delegate = self;
      
        [TITApprovedTreeJSON arrayOfTreesFromJSONwithSuccessBlock: ^(NSArray *inArray) {
            self.arrayOfTrees = inArray;
            //DLog(@"Called for JSON, returned array of count: %i", inArray.count);
            DLog(@"Called for JSON, tied array to property of count: %i", self.arrayOfTrees.count);
        }];
        
       _arrayOfApprovedTreeObjects = [[NSMutableArray alloc] init];
        TIApprovedTree *approvedTreeFactory = [[TIApprovedTree alloc] init];
        [approvedTreeFactory approvedTreeFactorywithSuccessBlock: ^(NSMutableArray *inArray)
         {
             _arrayOfApprovedTreeObjects = inArray;
             //DLog(@"Approved tree factory count %i", arrayOfApprovedTreeObjects.count);
         }];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //DLog(@"Array count as of number of rows and sections: %i", self.arrayOfTrees.count);
    //DLog(@"Object at index 0: %@", [self.arrayOfTrees objectAtIndex: 0]);
    return self.arrayOfTrees.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	while (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
	}
    
    
   if (indexPath.row < self.arrayOfTrees.count)
    {
        cell.textLabel.text = [self.arrayOfTrees objectAtIndex: indexPath.row];
        
        TIButton *tmpFavoriteButton = [TIButton buttonWithType:UIButtonTypeCustom];
        [tmpFavoriteButton setFrame:CGRectMake(0, 0, 30, 30)];
        [tmpFavoriteButton setBackgroundColor: [UIColor redColor]];
        [tmpFavoriteButton setTitle: @"FAV" forState: UIControlStateNormal];
        tmpFavoriteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        tmpFavoriteButton.undisplayedTitle = [self.arrayOfTrees objectAtIndex: indexPath.row];
        tmpFavoriteButton.buttonRow = indexPath.row;
        [tmpFavoriteButton addTarget: self action:@selector(addFavorite:) forControlEvents: UIControlEventTouchUpInside];
        
        [self testForDuplicity: tmpFavoriteButton];
        cell.accessoryView = tmpFavoriteButton;
    
    }
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
    //[TIWikiHandler stringToURL: [self.arrayOfTrees objectAtIndex: indexPath.row] andPushFor: self];
    TIApprovedTreeView *tmpView = [[TIApprovedTreeView alloc] initWithFrame: CGRectMake(0, 0, 320, 480) andApprovedTree:[_arrayOfApprovedTreeObjects objectAtIndex: indexPath.row]];
    tmpView.contentSize = CGSizeMake(320, 700);
    UIViewController *tmpController = [[UIViewController alloc] init];
    [tmpController.view addSubview: tmpView];
    [tmpView release];
    [self.navigationController pushViewController: tmpController animated: YES];
    [tmpController release];
}

@end
