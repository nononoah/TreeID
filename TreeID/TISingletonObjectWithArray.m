//
//  TISingletonObjectWithArray.m
//  TreeID
//
//  Created by Noah Blake on 1/29/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TISingletonObjectWithArray.h"

@implementation TISingletonObjectWithArray

+ (id)sharedInstance {
	static dispatch_once_t predicate;
	static TISingletonObjectWithArray *instance = nil;
	dispatch_once(&predicate, ^{instance = [[self alloc] init];});
	return instance;
}



-(id)init
{
    if ((self = [super init]))
    {
        _favoriteArray = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
