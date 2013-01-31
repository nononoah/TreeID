//
//  TISingletonObjectWithArray.h
//  TreeID
//
//  Created by Noah Blake on 1/29/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TISingletonObjectWithArray : NSObject

@property (nonatomic, retain) NSMutableArray *favoriteArray;
+ (id)sharedInstance;

@end
