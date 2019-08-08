//
//  ObjectiveCTryCatch.h
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 8/7/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCTryCatch : NSObject

/**
 Provides try catch functionality for swift by wrapping around Objective-C
 */

+ (void)try:(__attribute__((noescape))  void(^ _Nullable)(void))try catch:(__attribute__((noescape)) void(^ _Nullable)(NSException*exception))catch finally:(__attribute__((noescape)) void(^ _Nullable)(void))finally;
+ (void)throwString:(NSString*)s;
+ (void)throwException:(NSException*)e;
@end

NS_ASSUME_NONNULL_END
