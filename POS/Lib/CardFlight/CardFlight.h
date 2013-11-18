//
//  CardFlight.h
//  CardFlight
//
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardFlight : NSObject

+ (CardFlight *)sharedInstance;

// Returns the currect API Token
- (NSString *)getApiToken;

// Returns the currect Account Token
- (NSString *)getAccountToken;

// Initializes CardFlight API with API Token, Account Token and sets the delegate
- (void)setApiToken:(NSString *)cardFlightApiToken
       accountToken:(NSString *)cardFlightAccountToken;

- (NSString *)getReaderSerialNumber;

// Stop CardFlight and release all it's resources
- (void)stop;

@end