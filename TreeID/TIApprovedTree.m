//
//  TIApprovedTree.m
//  TreeID
//
//  Created by Noah Blake on 2/6/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIApprovedTree.h"
#import "TITApprovedTreeJSON.h"

@implementation TIApprovedTree

- (id) init
{
    self = [super init];
    if (self)
    {
        self.arrayOfApprovedTrees = [NSMutableArray array];
    }
    return self;
}

- (void) approvedTreeFactorywithSuccessBlock: (void (^)(NSMutableArray *inArray)) inSuccessBlock
{
    [TITApprovedTreeJSON arrayOfDataFromJSONwithSuccessBlock: ^(NSArray *inArray)
    {
        //by all rites, this should have been a second object here. I've slurred together a collection of objects and the object iself in a single object here, and I understand that's poor object management. 
        self.undifferentiatedArrayOfTrees = inArray;
        //DLog(@" self.undifferentiated array count: %i", self.undifferentiatedArrayOfTrees.count);
        for (int i = 0; i < self.undifferentiatedArrayOfTrees.count; ++i)
        {
            TIApprovedTree *approvedTree = [[TIApprovedTree alloc] init];
            approvedTree.scientificName = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 8];
            approvedTree.commonName = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 9];
            approvedTree.form = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 10];
            approvedTree.growthRate = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex:11];
            approvedTree.fallColor = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 12];
            approvedTree.environmentalTolerances = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 13];
            approvedTree.locationTolerances = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 14];
            approvedTree.notes = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 15];
            approvedTree.size = [[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 16];
    
            
            if ([[self.undifferentiatedArrayOfTrees objectAtIndex: i] objectAtIndex: 17] != [NSNull null])
                approvedTree.beetleQuarantine = YES;
         
            else
               approvedTree.beetleQuarantine = NO;
            
            [self.arrayOfApprovedTrees addObject: approvedTree];
            //DLog (@"Approved tree common name: %@", approvedTree.commonName);
        }
        //DLog (@"Approved tree count from factory: %i", self.arrayOfApprovedTrees.count);
        inSuccessBlock(self.arrayOfApprovedTrees);
    }];
}
@end
