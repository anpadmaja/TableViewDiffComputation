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

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;
@end

NS_ASSUME_NONNULL_END
