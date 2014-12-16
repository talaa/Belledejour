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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://graph.facebook.com/443490909081311/feed?access_token=CAAE040bEm1ABAEzywSR6j1QW9ZCZCtBdT7pVE4DlT9n6CpzS0NKCUr7wJRGrC1CLl3ZCvdxB2TLsuv11i1FZBm2PsEcJxgXaaWhqYSQj0qiyOYwBYZBkzxrOsm5rvdiC3cRzACvo8ZC63H5jV9YxOEvd9utAgEgU7jV7jXwzlnQvI50ETw0tMNtaVL4ij8edPesjmdo5sbcigfR2rQR0dC"]];
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
