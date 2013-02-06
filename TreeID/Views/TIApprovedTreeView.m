//
//  TIApprovedTreeView.m
//  TreeID
//
//  Created by Noah Blake on 2/6/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIApprovedTreeView.h"
#import "TIApprovedTree.h"


@implementation TIApprovedTreeView

- (id)initWithFrame:(CGRect)frame andApprovedTree: (TIApprovedTree *) inTree
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setBackgroundColor: [UIColor redColor]];
        
        self.scrollEnabled = YES;
    
        typedef enum {
            scientificName = 0,
            commonName,
            form,
            growthRate,
            fallColor,
            environmentalTolerances,
            locationTolerances,
            notes,
            size,
            beetleQuarantine,
            propertyCount
        } propertyTracker;
        
        void (^makeView)(NSString *, int) = ^(NSString *inString, int i) {
            UITextView *tmpView = [[UITextView alloc] init];
            tmpView.editable = NO;
            tmpView.text = inString;
            [tmpView setFrame: CGRectMake(0, 50 * i, 320, 50)];
            [self addSubview: tmpView];
            [tmpView release];
        };
        
        for (int i = 0; i < propertyCount; ++i)
        {
            switch (i)
            {
                case scientificName:
                    makeView(inTree.scientificName, i);
                    break;
                case commonName:
                    makeView(inTree.commonName, i);
                    break;
                case form:
                    makeView(inTree.form, i);
                    break;
                case growthRate:
                    makeView(inTree.growthRate, i);
                    break;
                case fallColor:
                    makeView(inTree.fallColor, i);
                    break;
                case environmentalTolerances:
                    makeView(inTree.environmentalTolerances, i);
                    break;
                case locationTolerances:
                    makeView(inTree.locationTolerances, i);
                    break;
                case notes:
                    makeView(inTree.notes, i);
                    break;
                case size:
                    makeView(inTree.size, i);
                    break;
                case beetleQuarantine:
                    if (inTree.beetleQuarantine)
                    {
                        DLog(@"Quarantine for beetles");
                        NSString *tmpString = @"Quarantine for beetles";
                        makeView(tmpString, i);
                    }
                    else
                    {
                        DLog(@"Don't quarantine for beetles");
                        NSString *tmpString = @"No beetle quarantine";
                        makeView(tmpString, i);
                    }
                    break;
                default:
                    break;
            }
        }
        
    }
    return self;
}

/*
scientificName;
commonName;
form;
growthRate;
fallColor;
environmentalTolerances;
locationTolerances;
notes;
size;
beetleQuarantine;
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
