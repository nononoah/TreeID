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
    TITreeDictionary *_treeDictionary;
}
@end

@implementation TIBaseViewController

- (id) init
{
    self = [super init];
    if (self)
    {
        _treeDictionary = [[TITreeDictionary alloc] init];
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

- (void) pushFromStart
{
    //because of the way I've built this, both the array and the controller can not be released. If they are, when the user reaches the end of the cladogram and attempts to press "start" again, the app will reach for a zombie. Is the solution here to make these instance variable that are released in dealloc? Is it not worth worrying about, since they're two objects that are made once and never remade - in other words, are minor leaks like this forgivable?
    NSArray *tmpArray = [_treeDictionary objectForKey: @"START"];
    TICladisticViewController *tmpController = [[TICladisticViewController alloc] initWithButtonArray: tmpArray];
    [self.navigationController pushViewController: tmpController animated:YES];
    [tmpController release];
}

- (void) setUpButtons: (NSArray *) inArray
{
    int sectionHeight = ([[UIScreen mainScreen] applicationFrame].size.height - (44 + 98)) / (inArray.count); //44 -> navbar, 98 -> tabbar
    int midScreen = ([[UIScreen mainScreen] applicationFrame].size.width) / 2;
    
    for (int i = 0; i < inArray.count; ++i)
    {
        UIButton *tmpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        NSString *title = [inArray objectAtIndex:i];
        [tmpButton setTitle: title forState: UIControlStateNormal];
      
        
        //autolayout would be smarter, but I'm not sure how to use it
        int buttonWidth = [title sizeWithFont: tmpButton.titleLabel.font].width + 5;
        //addional formatting for superwide buttons
        if (buttonWidth > [[UIScreen mainScreen] applicationFrame].size.width)
        {
            buttonWidth = [[UIScreen mainScreen] applicationFrame].size.width - 20;
            tmpButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        }
        int buttonHeight = [title sizeWithFont: tmpButton.titleLabel.font].height + 5;
        tmpButton.frame = CGRectMake(midScreen - ((buttonWidth) / 2), (sectionHeight * i) + ((sectionHeight / 2) - (buttonHeight / 2)) , buttonWidth, buttonHeight);
        
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
            popButton.frame = CGRectMake(midScreen - ((popButtonWidth) / 2), 50, popButtonWidth, buttonHeight);
            
            [self.view addSubview: popButton];
            
            [popButton	 addTarget: self.navigationController
                           action: @selector(popToRootViewControllerAnimated:)
                 forControlEvents: UIControlEventTouchUpInside];
        }
    }
}

- (void) nextViewController: (id) sender
{
    //takes string from button, finds the array that corresponds to it in the "database", view did load and setUpButtons finishes the job
    NSString *tmpString = [sender currentTitle];
    NSArray *tmpArray = [_treeDictionary objectForKey: tmpString];
    TICladisticViewController *tmpController = [[TICladisticViewController alloc] initWithButtonArray: tmpArray];
    [self.navigationController pushViewController:tmpController animated:YES];
    [tmpController release];
}

- (void) pushToWiki: (id) sender
{
    NSString *tmpString = [sender currentTitle];
    DLog(@"Sender's title %@", tmpString);
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
