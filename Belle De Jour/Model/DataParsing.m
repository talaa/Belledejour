//
//  DataParsing.m
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import "DataParsing.h"
#import "AppConstants.h"
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

+ (void)setDataParsingCurrentUserObject:(FIRDataSnapshot *)userData ImageData:(NSData *)data {
    //name
    [[NSUserDefaults standardUserDefaults] setObject:userData.value[UsersName] forKey:NSUsername];
    
    //email
    [[NSUserDefaults standardUserDefaults] setObject:userData.value[UsersEmail] forKey:NSUserEmail];
    
    //phone
    [[NSUserDefaults standardUserDefaults] setObject:userData.value[UsersPhone] forKey:NSUserPhone];
    
    //profilePic URL
    [[NSUserDefaults standardUserDefaults] setObject:userData.value[UsersPhotoURL] forKey:NSUserPhotoURL];
    
    //imageData
    [[NSUserDefaults standardUserDefaults] setObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:userData.value[UsersPhotoURL]]] forKey:NSUserImageData];
    
    //points
    if (userData.value[UsersPoints] != nil){
        [[NSUserDefaults standardUserDefaults] setObject:userData.value[UsersPoints] forKey:NSUserPoints];
    }
}

//get name
+(NSString*)getUserName {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUsername];
}

//get phone
+(NSString*)getUserPhone {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUserPhone];
}

//get email
+(NSString*)getUseremail {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUserEmail];
}

//get imageData
+(NSData*)getImageData {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUserImageData];
}

//get ProfileURL
+(NSString*)getUserProfileURL {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUserPhotoURL];
}

//get points
+(NSNumber*)getUserPoints {
    return [[NSUserDefaults standardUserDefaults] valueForKey:NSUserPoints];
}

@end
