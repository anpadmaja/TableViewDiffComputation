//
//  ObjectiveCTryCatch.m
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 8/7/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

#import "ObjectiveCTryCatch.h"

@implementation ObjectiveCTryCatch

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error {
  @try {
    tryBlock();
    return YES;
  }
  @catch (NSException *exception) {
    *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
  }
}

@end
