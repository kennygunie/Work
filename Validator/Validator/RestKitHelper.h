//
//  RestKitHelper.h
//  Validator
//
//  Created by Kien Nguyen on 13/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestKitHelper : NSObject

+ (RestKitHelper *)sharedRestKitHelper;

+ (void)setupRestKit;

@end
