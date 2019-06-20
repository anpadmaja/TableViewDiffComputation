//
//  TestEquatableObjCProps.h
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 5/13/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestEquatableObjCProps : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *number;

- (instancetype)initWithName:(NSString *)name number:(NSNumber *)number;

@end

NS_ASSUME_NONNULL_END
