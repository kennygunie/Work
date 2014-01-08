//
//  RestKitHelper.m
//  Validator
//
//  Created by Kien Nguyen on 13/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "RestKitHelper.h"
#import "SynthesizeSingleton.h"

@interface RestKitHelper ()

- (RKResponseDescriptor *)errorDescriptor;
- (RKResponseDescriptor *)demandeDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;

- (NSDictionary *)parentObjectMapping;

@end

@implementation RestKitHelper

NSString* const kAPIURL = @"https://api.parse.com/1/";

NSString* const kHeaderAPIKey = @"X-Parse-REST-API-Key";
NSString* const kValueAPIKey = @"w8CHiJmBDKKYTSaUIHFkFA29aJgVocp3fecBJnTN";
NSString* const kHeaderAppId = @"X-Parse-Application-Id";
NSString* const kValueAppId = @"pyQOwfTYyPIQG2BYqwdGj29hpWJU7X3KqLeW0MsN";

SYNTHESIZE_SINGLETON_FOR_CLASS(RestKitHelper)

+ (void)setupRestKit
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    
    // Initialize RestKit
    NSURL *baseURL = [NSURL URLWithString:kAPIURL];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    [[objectManager HTTPClient] setDefaultHeader:kHeaderAPIKey
                                           value:kValueAPIKey];
    [[objectManager HTTPClient] setDefaultHeader:kHeaderAppId
                                           value:kValueAppId];
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    
    RKResponseDescriptor *errorDescriptor = [[self sharedRestKitHelper] errorDescriptor];
    RKResponseDescriptor *demandeDescriptor = [[self sharedRestKitHelper] demandeDescriptorWithManagedObjectStore:objectManager.managedObjectStore];
    
    [objectManager addResponseDescriptorsFromArray:@[demandeDescriptor, errorDescriptor]];
    
    // Complete Core Data stack initialization
    
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Validator.sqlite"];
    
    NSError *error;
    
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                     fromSeedDatabaseAtPath:nil
                                                                          withConfiguration:nil
                                                                                    options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
                                                                                      error:&error];
    
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
}

- (RKResponseDescriptor *)errorDescriptor
{
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                           toKeyPath:@"errorMessage"]];
    
    RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                         method:RKRequestMethodAny
                                                                                    pathPattern:nil
                                                                                        keyPath:@"error"
                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    return errorDescriptor;
}

- (RKResponseDescriptor *)demandeDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore
{
    RKEntityMapping *demandeMapping = [RKEntityMapping mappingForEntityForName:@"Demande"
                                                          inManagedObjectStore:managedObjectStore];
    demandeMapping.identificationAttributes = @[ @"objectId" ];
    [demandeMapping addAttributeMappingsFromDictionary:@{
                                                         @"detail" : @"detail",
                                                         @"subject" : @"subject",
                                                         @"valid" : @"valid",
                                                         @"value" : @"value",
                                                         }];
    
    [demandeMapping addAttributeMappingsFromDictionary:[self parentObjectMapping]];
    
    
    // Register our mappings with the provider
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:demandeMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"classes/Demande"
                                                                                           keyPath:@"results"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

- (NSDictionary *)parentObjectMapping
{
    return @{
             @"objectId" : @"objectId",
             @"updatedAt" : @"updatedAt",
             @"createdAt" : @"createdAt",
             };
}

@end
