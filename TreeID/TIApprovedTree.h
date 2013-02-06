//
//  TIApprovedTree.h
//  TreeID
//
//  Created by Noah Blake on 2/6/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIApprovedTree : NSObject


- (void) approvedTreeFactorywithSuccessBlock: (void (^)(NSMutableArray *inArray)) inSuccessBlock;

@property (nonatomic, retain) NSArray *undifferentiatedArrayOfTrees;
@property (nonatomic, retain) NSMutableArray *arrayOfApprovedTrees;

@property (nonatomic, copy) NSString *scientificName;
@property (nonatomic, copy) NSString *commonName;
@property (nonatomic, copy) NSString *form;
@property (nonatomic, copy) NSString *growthRate;
@property (nonatomic, copy) NSString *fallColor;
@property (nonatomic, copy) NSString *environmentalTolerances;
@property (nonatomic, copy) NSString *locationTolerances;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSString *size;
@property (nonatomic)       BOOL     *beetleQuarantine;

@end
