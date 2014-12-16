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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://graph.facebook.com/443490909081311/feed?access_token=CAAE040bEm1ABACimmCeqaMD8MDnRMCwjDJPB0jw52X1pBjN1hBPMPWDT9M29GfNFALIoLUBe6DyZAsECvHIZCz3TnemVe6ITNCyYhVeKfFqLu8zHVnUw42Mv9eN6Gja51TmbiNj5mdT8NZAMupaTWHUuj3G9vjeVwjZBeTXLr0230GpQFuatOD2zUplFcGiFfil10tMCZCZBFwBynVHhZB4"]];
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
