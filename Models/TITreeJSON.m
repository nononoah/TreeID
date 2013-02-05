//
//  TITreeJSON.m
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITreeJSON.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@implementation TITreeJSON

+ (NSNumber *) arrayCountFromJSON
{
    NSURL *url = [NSURL URLWithString:@"http://data.cityofnewyork.us/api/views/99wq-x9cr/rows.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSArray *arrayOfTreesFromJSON = nil;
    NSNumber *arrayCountFromJSON;
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        arrayOfTreesFromJSON = [NSArray arrayWithArray: [JSON valueForKey:@"data"]];
        DLog(@"Array of trees count: %i", arrayOfTreesFromJSON.count);
    } failure:nil];
    
    [operation start];
    DLog(@"Is the operation executing: %c", operation.isExecuting);
    
    arrayCountFromJSON = arrayOfTreesFromJSON.count;
    DLog(@"Array of trees count: %@", arrayCountFromJSON);
    return arrayCountFromJSON;
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
