//
//  TITreeJSON.h
//  TreeID
//
//  Created by Noah Blake on 2/5/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TITreeJSON : NSObject
{
}
+ (NSNumber *) arrayCountFromJSON;
+ (void) arrayOfTreesFromJSONwithSuccessBlock: (void (^)(NSArray *inArray)) inSuccessBlock;
@end
