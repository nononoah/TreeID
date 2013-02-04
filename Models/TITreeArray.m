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
    
    //this loop separates all of the individual trees from the cladistic dictionary of trees and their descriptors. Key steps through the dictionaries keys, and if key corresponds to the value of an array that only has one element, it is the key to a single tree. This single tree is stored in a new array.
    
    for (id key in tmpTreeDictionary)
    {
        //DLog(@"Key is equal to %@", key);
        NSArray *tmpArray = [tmpTreeDictionary objectForKey: key];
        if (tmpArray.count == 1)
        {
            [tmpMutableArray addObject: [[tmpTreeDictionary objectForKey: key] objectAtIndex:0]];
            //DLog(@"Object added of class: %@", [[[tmpTreeDictionary objectForKey: key] objectAtIndex:0] class]);
        }
    }
    [tmpTreeDictionary release];
    return [NSArray arrayWithArray: tmpMutableArray];
}



@end
