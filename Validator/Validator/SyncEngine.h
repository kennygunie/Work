//
//  SyncEngine.h
//  Validator
//
//  Created by Kien Nguyen on 08/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncEngine : NSObject

@property (nonatomic, strong) NSMutableArray *registeredClassesToSync;

+ (SyncEngine *)sharedSyncEngine;

- (void)registerNSManagedObjectClassToSync:(Class)aClass;
- (void)startSync;

/**
 Get all demandes from remote DB and save them to CoreData
 @param success action when success
 @param failure action when failure
 */
- (void)getAllRemotesDemandesOnSuccess:(void (^)(void))success
                               failure:(void (^)(NSError *error))failure;


@end
