//
//  TIWikiHandler.h
//  TreeID
//
//  Created by Noah Blake on 1/30/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIWikiHandler : NSObject
+ (void) stringToURL: (NSString *) inString andPushFor: (UIViewController *) inController;
+ (NSString *) stringToURL:(NSString *)inString;

@end
