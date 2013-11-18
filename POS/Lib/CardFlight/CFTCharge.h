//
//  Charge.h
//  CardFlightLibrary
//
//  Created by Tim Saunders on 9/20/13.
//  Copyright (c) 2013 CardFlight Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardFlight.h"
#import "CFTAPIResource.h"

@interface CFTCharge : CFTAPIResource

@property (nonatomic) NSString *amount;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *referenceID;
@property (nonatomic) BOOL isRefunded;
@property (nonatomic) NSString *amountRefunded;
@property (nonatomic) NSDate *created;

- (id)initWithServerResponse:(NSDictionary *)dictionary;

/**
 * Refund a charge and post to the CardFlight servers
 * @param chargeDictionary A dictionary containing amount, description, currency required to refund the charge
 */
-(void) refundCharge:(NSDictionary *)chargeDictionary;

@end
