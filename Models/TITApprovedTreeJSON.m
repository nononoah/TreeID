//
//  TITreeJSON.m
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITApprovedTreeJSON.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@implementation TITApprovedTreeJSON

+ (void) arrayOfDataFromJSONwithSuccessBlock: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSURL *url = [NSURL URLWithString:@"http://data.cityofnewyork.us/api/views/99wq-x9cr/rows.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *arrayOfTrees = [NSArray arrayWithArray: [JSON valueForKey:@"data"]];
        inSuccessBlock(arrayOfTrees);
    } failure:nil];

    [operation start];
}

+ (void) arrayOfTreesFromJSONwithSuccessBlock: (void (^)(NSArray *inArray)) inSuccessBlock
{
    NSURL *url = [NSURL URLWithString:@"http://data.cityofnewyork.us/api/views/99wq-x9cr/rows.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSMutableArray *arrayOfTrees = [NSMutableArray array];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       NSArray * arrayOfDataFromJSON = [NSArray arrayWithArray: [JSON valueForKey:@"data"]];
        //DLog(@"What the array looks like:\n %@", arrayOfDataFromJSON);
        for (int i = 0; i < arrayOfDataFromJSON.count; ++i)
        {
            [arrayOfTrees addObject: [[arrayOfDataFromJSON objectAtIndex: i] objectAtIndex: 9]];
             //DLog (@"Counting array, count: %i", arrayOfTrees.count);
        }
        //DLog (@"Finished array, count: %i", arrayOfTrees.count);
        inSuccessBlock(arrayOfTrees);
    } failure:nil];
    
    [operation start];
    
    DLog(@"Called success block");
}


@end
