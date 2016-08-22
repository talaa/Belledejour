//
//  DataParsing.m
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import "DataParsing.h"

@implementation DataParsing

static DataParsing *instance = nil;

+(DataParsing *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataParsing new];
        }
    }
    return instance;
}
@end
