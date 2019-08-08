//
//  ObjectiveCTryCatch.m
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 8/7/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

#import "ObjectiveCTryCatch.h"

#import "ObjectiveCTryCatch.h"

@implementation ObjectiveCTryCatch

/**
 Provides try catch functionality for swift by wrapping around Objective-C
 */
+ (void)try:(__attribute__((noescape))  void(^ _Nullable)(void))try catch:(__attribute__((noescape)) void(^ _Nullable)(NSException*exception))catch finally:(__attribute__((noescape)) void(^ _Nullable)(void))finally
{
  @try {
    if (try != NULL) try();
  }
  @catch (NSException *exception) {
    if (catch != NULL) catch(exception);
  }
  @finally {
    if (finally != NULL) finally();
  }
}

+ (void)throwString:(NSString*)s
{
  @throw [NSException exceptionWithName:s reason:s userInfo:nil];
}

+ (void)throwException:(NSException*)e
{
  @throw e;
}

@end
