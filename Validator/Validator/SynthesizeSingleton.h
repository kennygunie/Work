//
//  SynthesizeSingleton.h
//  Validator
//
//  Created by Kien Nguyen on 13/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#ifndef Validator_SynthesizeSingleton_h
#define Validator_SynthesizeSingleton_h

    #if __has_feature(objc_arc) // ARC Version
        #define SYNTHESIZE_SINGLETON_FOR_CLASS(classname)   \
        \
        + (classname *)shared##classname\
        {\
            static classname *shared##classname = nil;\
            static dispatch_once_t onceToken;\
            dispatch_once(&onceToken, ^{\
                shared##classname = [[classname alloc] init];\
            });\
            return shared##classname;\
        }
    #endif


#endif
