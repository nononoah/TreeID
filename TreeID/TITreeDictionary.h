//
//  TITreeDictionary.h
//  TreeID
//
//  Created by Noah Blake on 1/25/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TITreeDictionary : NSObject

@property (nonatomic, retain) NSDictionary *treeDictionary;
+ (id)sharedInstance;

@end
