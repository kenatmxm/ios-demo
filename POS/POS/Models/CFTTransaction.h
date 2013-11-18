//
//  CFTTransaction.h
//  POS
//
//  Created by Paul Tower on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFTTransaction : NSObject

@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic) NSString *descriptionText;

- (NSString *)amountAsString;
- (NSString *)amountInCents;

@end
