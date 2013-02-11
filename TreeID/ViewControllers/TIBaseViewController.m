//
//  TIBaseViewController.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIBaseViewController.h"
#import "TITreeDictionary.h"
#import "TICladisticViewController.h"
#import "TIWikiHandler.h"



@interface TIBaseViewController ()
{
    NSArray *arrayOfTrees;
}
@end

@implementation TIBaseViewController

- (id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *tmpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [tmpButton setTitle: @"Start" forState: UIControlStateNormal];
    tmpButton.frame = CGRectMake(200, 200, 80, 40);
    [self.view addSubview: tmpButton];
    [tmpButton addTarget: self action: @selector(pushFromStart) forControlEvents: UIControlEventTouchUpInside];
}

- (void) viewDidAppear:(BOOL)animated
{

  
}

- (void) pushFromStart
{
    //this is relatively abusive, and not how one should use a parent, but the parent here serves primarily to present the opening view (and the methods that help format the views that follow). This method marks the practical end of the parent's view life cycle. 
    NSArray *tmpArray = [TREEDICTIONARY objectForKey: @"START"];
    TICladisticViewController *tmpController = [[TICladisticViewController alloc] initWithButtonArray: tmpArray];
    [self.navigationController pushViewController: tmpController animated:YES];
    [tmpController release];
}

- (void) setUpButtons: (NSArray *) inArray
{
    //divide the screen into a number of sections equal to the number of buttons
    int sectionHeight = ([[UIScreen mainScreen] applicationFrame].size.height - (44 + 98)) / (inArray.count); //44 -> navbar, 98 -> tabbar
    //DLog(@"sectionHeght: %i", sectionHeight);
    
    //the x-coordinate of the middle of the screen, used to center buttons horizontally
    int midScreenX = ([[UIScreen mainScreen] applicationFrame].size.width) / 2;
    
    //make as many buttons as the array (that the previously pressed button keyed) called for
    for (int i = 0; i < inArray.count; ++i)
    {
        UIButton *tmpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        //the button's title is pulled from the array
        NSString *title = [inArray objectAtIndex:i];
        [tmpButton setTitle: title forState: UIControlStateNormal];
      
        
        //button width reflects title's length
        int buttonWidth = [title sizeWithFont: tmpButton.titleLabel.font].width + 5;
        //addional formatting for superwide buttons
        if (buttonWidth > [[UIScreen mainScreen] applicationFrame].size.width)
        {
            buttonWidth = [[UIScreen mainScreen] applicationFrame].size.width - 20;
            tmpButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        }
        
        //button's height is consistent among all buttons
        int buttonHeight = [title sizeWithFont: tmpButton.titleLabel.font].height + 5;
        
        //frame centers the button horizontally and vertically
        /*
         vertical centering unpacked:    (sectionHeight * i)  -> jump to y position that corresponds with the top of the section
                                      +  ((sectionHeight / 2) -> jump down to the middle of the section
                                      -  (buttonHeight / 2)   -> move back up half the height of the button
                                      +  20                   -> account for status bar
        */
        tmpButton.frame = CGRectMake(midScreenX - ((buttonWidth) / 2), (sectionHeight * i) + ((sectionHeight / 2) - (buttonHeight / 2)) + 20, buttonWidth, buttonHeight);
        [self.view addSubview: tmpButton];
        
        //if you haven't reached the end of a branch, set up buttons to push to next branches
        if (inArray.count != 1)
        {
            [tmpButton	 addTarget: self
                         action: @selector(nextViewController:)
               forControlEvents: UIControlEventTouchUpInside];
        }
        
        //if you have hit the end of a branch, button will lead to wiki, add button to go home
        else
        {
            [tmpButton	 addTarget: self
                           action: @selector(pushToWiki:)
               forControlEvents: UIControlEventTouchUpInside];
            
            //pop button
            UIButton *popButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            NSString *tmpString = @"Back to the start";
            [popButton setTitle: tmpString forState: UIControlStateNormal];
            
            int popButtonWidth = [tmpString sizeWithFont: popButton.titleLabel.font].width;
            popButton.frame = CGRectMake(midScreenX - ((popButtonWidth) / 2), 50, popButtonWidth, buttonHeight);
            
            [self.view addSubview: popButton];
            
            [popButton	 addTarget: self.navigationController
                           action: @selector(popToRootViewControllerAnimated:)
                 forControlEvents: UIControlEventTouchUpInside];
        }
    }
}

- (void) nextViewController: (id) sender
{
    //takes string from button, finds the array that corresponds to it in the dictionary database, that array then dictates how many buttons are in the following view controller and what content these buttons contain. Refer to setUpButtons to see how this is done. 
    NSString *tmpString = [sender currentTitle];
    NSArray *tmpArray = [TREEDICTIONARY objectForKey: tmpString];
    TICladisticViewController *tmpController = [[TICladisticViewController alloc] initWithButtonArray: tmpArray];
    [self.navigationController pushViewController: tmpController animated: YES];
    [tmpController release];
}

- (void) pushToWiki: (id) sender
{
    NSString *tmpString = [sender currentTitle];
    DLog(@"Sender's title as it calls for wiki push %@", tmpString);
    [TIWikiHandler stringToURL: tmpString andPushFor: self];
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
