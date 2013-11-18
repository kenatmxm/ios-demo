//
//  CFTTransaction.m
//  POS
//
//  Created by Paul Tower on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTTransaction.h"

@implementation CFTTransaction

#pragma mark - Public Methods

- (NSString *)amountAsString {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:_amount];
}

- (NSString *)amountInCents {
    
    return [_amount stringValue];
}

@end
