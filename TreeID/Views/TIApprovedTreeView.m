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
        
        void (^makeView)(NSString *, NSString *, int) = ^(NSString *inTitle, NSString *inField, int i) {
            UITextView *tmpView = [[UITextView alloc] init];
            tmpView.editable = NO;
            NSMutableString *tmpTitle = [NSMutableString stringWithString: inTitle];
            NSString *tmpField = inField;
            [tmpTitle appendString: tmpField];
            tmpView.text = tmpTitle;
            [tmpView setFrame: CGRectMake(0, 50 * i, 320, 50)];
            [self addSubview: tmpView];
            [tmpView release];
        };
        
        for (int i = 0; i < propertyCount; ++i)
        {
            switch (i)
            {
                case scientificName:
                    makeView(@"Scientific name: ", inTree.scientificName, i);
                    break;
                case commonName:
                    makeView(@"Common name: ", inTree.commonName, i);
                    break;
                case form:
                    makeView(@"Tree form: ", inTree.form, i);
                    break;
                case growthRate:
                    makeView(@"Growth rate: ", inTree.growthRate, i);
                    break;
                case fallColor:
                    makeView(@"Fall foliage color: ", inTree.fallColor, i);
                    break;
                case environmentalTolerances:
                    makeView(@"Environmental tolerances: ", inTree.environmentalTolerances, i);
                    break;
                case locationTolerances:
                    makeView(@"Location tolerances: ", inTree.locationTolerances, i);
                    break;
                case notes:
                    makeView(@"Notes: ", inTree.notes, i);
                    break;
                case size:
                    makeView(@"Size: ", inTree.size, i);
                    break;
                case beetleQuarantine:
                    if (inTree.beetleQuarantine)
                    {
                        DLog(@"Quarantine for beetles");
                        NSString *tmpString = @"Quarantine for beetles";
                        makeView(@"Quarantine note: ", tmpString, i);
                    }
                    else
                    {
                        DLog(@"Don't quarantine for beetles");
                        NSString *tmpString = @"No beetle quarantine";
                        makeView(@"Quarantine note: ", tmpString, i);
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
