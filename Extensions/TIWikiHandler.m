//
//  TIWikiHandler.m
//  TreeID
//
//  Created by Noah Blake on 1/30/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "TIWikiHandler.h"

@implementation TIWikiHandler

+ (void) stringToURL: (NSString *) inString andPushFor: (UIViewController *) inController
{
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wikiWebView = [[UIWebView alloc] initWithFrame:  appFrame];
    wikiWebView.scalesPageToFit = YES;
    NSMutableString *tmpURLString = [NSMutableString stringWithString: @"http://en.m.wikipedia.org/wiki/"];
    
    
    NSMutableString *tmpString = [NSMutableString stringWithString:[inString lowercaseString]];
    NSArray *tmpArray = [tmpString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString *nospacestring = [tmpArray componentsJoinedByString:@"_"];
    
    //[appendString stringByReplacingOccurrencesOfString:[NSCharacterSet whitespaceCharacterSet] withString:@"_"];
    
    [tmpURLString appendString: nospacestring];
    DLog(@"%@", tmpURLString);
    
    NSURL *tmpWebUrl = [NSURL URLWithString: tmpURLString];
    NSData *tmpData = [NSData dataWithContentsOfURL: tmpWebUrl];
    [wikiWebView loadData: tmpData MIMEType: @"text/html" textEncodingName: @"NSUTF8StringEncoding" baseURL: tmpWebUrl];
    
    
    UIViewController *tmpController = [[UIViewController alloc] init];
    [tmpController.view addSubview: wikiWebView];
    tmpController.title = tmpString;
    [wikiWebView release];
    
    [inController.navigationController pushViewController: tmpController animated:YES];
    [tmpController release];
}

+ (NSString *) stringToURL:(NSString *)inString
{
    NSMutableString *tmpURLString = [NSMutableString stringWithString: @"http://en.m.wikipedia.org/wiki/"];
    
    NSMutableString *tmpString = [NSMutableString stringWithString: [inString lowercaseString]];
    NSArray *tmpArray = [tmpString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString *tmpNoSpaceString = [tmpArray componentsJoinedByString:@"_"];
    
    [tmpURLString appendString: tmpNoSpaceString];
    return tmpURLString;
}
@end
