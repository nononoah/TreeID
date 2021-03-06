//
//  TITabBarController.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITabBarController.h"
#import "TIBaseViewController.h"
#import "TISearchTableViewController.h"
#import "TISavedTableViewController.h"
#import "TIApprovedTreesViewController.h"

@interface TITabBarController ()

@end

@implementation TITabBarController

- (id)init
{
    self = [super init];
    if (self) {
    
        
        NSMutableArray *tmpMutableArray = [[NSMutableArray alloc] init];
        NSArray *tmpArray = [NSArray arrayWithObjects: @"ID", @"Search", @"Saved", @"Approved", nil];
       int i = 0;

        //the Luu tab bar construction approach. By generically init'ing these controllers, I put myself in a quandary that I solved through questionable means in the relationship between TIBaseViewController and TICladisticViewController. 
		for (Class tmpClass in @[[TIBaseViewController class], [TISearchTableViewController class], [TISavedTableViewController class], [TIApprovedTreesViewController class]])
		{
			UINavigationController *tmpNavController = [[UINavigationController alloc] initWithRootViewController:[[[tmpClass alloc] init] autorelease]];
            tmpNavController.title = [tmpArray objectAtIndex: i];
			[tmpMutableArray addObject:tmpNavController];
			[tmpNavController release];
            i++;
		}
        
        [self setViewControllers: tmpMutableArray];
        [tmpMutableArray release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [super dealloc];
}

@end

