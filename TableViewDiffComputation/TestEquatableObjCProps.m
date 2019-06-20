//
//  TestEquatableObjCProps.m
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 5/13/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

#import "TestEquatableObjCProps.h"

@implementation TestEquatableObjCProps

- (instancetype)initWithName:(NSString *)name number:(NSNumber *)number
{
  self = [super init];
  if (self) {
    self.name = name;
    self.number = number;
  }
  return self;
}

@end
