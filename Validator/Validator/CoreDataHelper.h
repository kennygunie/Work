//
//  CoreDataHelper.h
//  Validator
//
//  Created by Kien Nguyen on 13/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Demande;

@interface CoreDataHelper : NSObject

+(CoreDataHelper *)sharedCoreDataHelper;

- (Demande *)getLastLocalDemande;

@end
