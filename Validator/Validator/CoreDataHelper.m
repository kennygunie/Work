//
//  CoreDataHelper.m
//  Validator
//
//  Created by Kien Nguyen on 13/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "CoreDataHelper.h"
#import "SynthesizeSingleton.h"
#import "Demande+Utils.h"

@implementation CoreDataHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(CoreDataHelper)

- (Demande *)getLastLocalDemande
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Demande class])];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"updatedAt"
                                                                   ascending:NO]];
    fetchRequest.fetchLimit = 1;
    NSManagedObjectContext *managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    
    NSError *error;
    NSArray *fetchResults = [managedObjectContext executeFetchRequest:fetchRequest
                                                                error:&error];
    if ([fetchResults count] == 1) {
        return fetchResults[0];
    }
    return nil;
}
@end
