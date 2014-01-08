//
//  Demande.h
//  Validator
//
//  Created by Kien Nguyen on 12/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RemoteObject.h"


@interface Demande : RemoteObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * valid;
@property (nonatomic, retain) NSNumber * value;

@end
