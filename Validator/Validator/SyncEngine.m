//
//  SyncEngine.m
//  Validator
//
//  Created by Kien Nguyen on 08/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "SyncEngine.h"
#import "SynthesizeSingleton.h"

@implementation SyncEngine

SYNTHESIZE_SINGLETON_FOR_CLASS(SyncEngine)

- (void)registerNSManagedObjectClassToSync:(Class)aClass {
    if (!self.registeredClassesToSync) {
        self.registeredClassesToSync = [NSMutableArray array];
    }
    
    if ([aClass isSubclassOfClass:[NSManagedObject class]]) {
        if (![self.registeredClassesToSync containsObject:NSStringFromClass(aClass)]) {
            [self.registeredClassesToSync addObject:NSStringFromClass(aClass)];
        } else {
            NSLog(@"Unable to register %@ as it is already registered", NSStringFromClass(aClass));
        }
    } else {
        NSLog(@"Unable to register %@ as it is not a subclass of NSManagedObject", NSStringFromClass(aClass));
    }
    
}

- (void)startSync
{
    
}

- (void)getAllRemotesDemandesOnSuccess:(void (^)(void))success
                               failure:(void (^)(NSError *error))failure;
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"classes/Demande"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  RKLogInfo(@"Load complete: Table should refresh...");
                                                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                  if (success) {
                                                      success();
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Error: %@",error);
                                                  if (failure) {
                                                      failure(error);
                                                  }
                                              }];
}

@end
