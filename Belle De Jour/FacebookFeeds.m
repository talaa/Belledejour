//
//  FacebookFeeds.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/16/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "FacebookFeeds.h"
#import "DataParser.h"
@implementation FacebookFeeds
+(void)parseFacebookFeeds
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://graph.facebook.com/443490909081311/feed?access_token=CAAE040bEm1ABAGoE779RwIqL0i3Vv2oUqnlEuUS60LN2ZCjGr0WJ8mI9tPMhQpwPuutQ81bmnEOaYKwNGhXB1QT5JHtcZAShaOiZByATMeLuWZCRU92FZAP6j0n7FkcAALkpqfnLfYuvTjcXG1oYDJzhPEweh7ZBAme6PRl4YbtiojfbspGgisQkV9KFaRYFERC2zvqxUF78ZALUi6BdZAqT"]];
    request.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if ([data length] > 0){
                                   NSDictionary* parsedData = [DataParser parseData:(NSMutableData *)data];
                                   
                                   dispatch_async(dispatch_get_main_queue(),^{
                                       [[NSNotificationCenter defaultCenter]postNotificationName:@"FeedsRecieved" object:nil userInfo:parsedData];
                                   });
                                   
                                   
                               }
                               else {
                                   dispatch_async(dispatch_get_main_queue(),^{
                                       [[NSNotificationCenter defaultCenter]postNotificationName:@"FeedsTimeOut" object:nil];
                                       // SHOW_ALERT(@"", @"");
                                   });
                                   
                               }
                           }];
}
@end
