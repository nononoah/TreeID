//
//  TITreeCensueJSON.m
//  TreeID
//
//  Created by Noah Blake on 2/7/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITreeCensusJSON.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@implementation TITreeCensusJSON

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}
 /*
+ (void) arrayOfPlantedTreesFromJSONwithSuccessBlock: (void (^)(NSArray *inArray)) inSuccessBlock
{
   
    //NSURL *url = [NSURL URLWithString:@"http://data.cityofnewyork.us/api/views/99wq-x9cr/rows.json"];
    NSURL *url = [NSURL URLWithString:@"http://data.cityofnewyork.us/api/views/e6n3-m3vc/rows.json"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSMutableArray *arrayOfTrees = [NSMutableArray array];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        DLog(@"Trying to make this array.");
        NSArray *arrayOfDataFromJSON = [NSArray arrayWithArray: [JSON valueForKey:@"view"]];
       //DLog(@"What the array looks like:\n %@", arrayOfDataFromJSON);
        //for (int i = 0; i < arrayOfDataFromJSON.count; ++i)
        //{
        //}
        //inSuccessBlock(arrayOfTrees);
    } failure:nil];
    
    [operation start];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:@"download.zip" append:NO];

    
    DLog(@"Called success block");
    
}

+ (void)fetchJSON:(void (^)(NSArray *inArray))inSuccess
{
    
	NSString *filePath = [[NSBundle mainBundle] pathForResource: @"treeCensus" ofType:@"json"];
    DLog(@"loading from %@", filePath);
	
    NSData *myData = [NSData dataWithContentsOfFile: filePath];
    NSLog(@"My data is %d btyes", myData.length);
   
	if (myData)
	{
        // we have data, check validity
        if ( [NSJSONSerialization isValidJSONObject:myData] ) {
            // valid, parse
            NSError* error = nil;
            id result = [NSJSONSerialization JSONObjectWithData: myData options:kNilOptions error:&error];
            inSuccess(result);
        }else {
            // invalid
            DLog(@"invalid json");
        }
    } else {
        // myData is nil
        DLog(@"no data loaded from disk");
    }
}



*/

@end
