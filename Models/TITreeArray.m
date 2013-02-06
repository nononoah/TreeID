//
//  TITreeArray.m
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TITreeArray.h"
#import "TITreeDictionary.h"

@implementation TITreeArray

+ (NSArray *) treeArray
{
    TITreeDictionary *tmpTreeDictionary = [[TITreeDictionary alloc] init];
    NSMutableArray *tmpMutableArray = [[[NSMutableArray alloc] init] autorelease];
    
    //this loop separates all of the individual trees from the cladistic dictionary of trees and their descriptors. Key steps through the dictionaries keys, and if key corresponds to the value of an array that only has one element, it is the key to a single tree. Before this single tree is stored in a new array, it is checked to see if it already exists there. 
    
    for (id key in tmpTreeDictionary)
    {
        //DLog(@"Key is equal to %@", key);
        NSArray *tmpArray = [tmpTreeDictionary objectForKey: key];
        BOOL foundDuplicate = NO;
        if (tmpArray.count == 1)
        {
            NSString *tmpString = [[[tmpTreeDictionary objectForKey: key] objectAtIndex:0] capitalizedString];
           // DLog(@"Temp string: %@", tmpString);
            for (NSString *tmpStepString in tmpMutableArray)
            {
                NSComparisonResult *result = [tmpStepString compare: tmpString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, tmpString.length)];
                //DLog (@"Made a comparison, result is %c", (result == NSOrderedSame));
                if (result == NSOrderedSame)
                {
                   // DLog(@"Don't add duplicate");
                    foundDuplicate = YES;
                }
            }
            
            if (foundDuplicate == NO)
                [tmpMutableArray addObject: tmpString];
            
            if (foundDuplicate == YES)
                foundDuplicate = NO;
           
            //DLog(@"Object added of class: %@", [[[tmpTreeDictionary objectForKey: key] objectAtIndex:0] class]);
        }
    }
                    
    [tmpTreeDictionary release];
    return [NSArray arrayWithArray: tmpMutableArray];
}



@end
