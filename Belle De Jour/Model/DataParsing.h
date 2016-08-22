//
//  DataParsing.h
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface DataParsing : NSObject

@property (nonatomic , retain) FIRDatabaseReference *referenceFirebaseDatabase;
@property (nonatomic , retain) FIRStorage *firebaseStorage;
@property (nonatomic , retain) FIRStorageReference * referenceFirebaseStorage;

+ (DataParsing*)getInstance;
@end
