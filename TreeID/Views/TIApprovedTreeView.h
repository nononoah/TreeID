//
//  TIApprovedTreeView.h
//  TreeID
//
//  Created by Noah Blake on 2/6/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TIApprovedTree;

@interface TIApprovedTreeView : UIScrollView

- (id)initWithFrame:(CGRect)frame andApprovedTree: (TIApprovedTree *) inTree;

@end
