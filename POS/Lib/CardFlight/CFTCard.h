//
//  Card.h
//  CardFlightLibrary
//
//  Created by Paul Tower on 11/4/13.
//  Copyright (c) 2013 CardFlight Inc. All rights reserved.
//

#import "CFTAPIResource.h"
@class CFTCharge;

typedef enum CFCardType {
    UNKNOWN,
    VISA,
    MASTERCARD,
    AMEX,
    DINERS,
    DISCOVER,
    JCB
} CFCardType;

@interface CFTCard : CFTAPIResource

@property (nonatomic) NSString *last4;
@property (nonatomic) NSInteger expirationMonth;
@property (nonatomic) NSInteger expirationYear;
@property (nonatomic) CFCardType cardType;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *encryptedCardNumber;

- (id)initWithCardNumber:(NSString *)cardNumber
         expirationMonth:(NSInteger)cardMonth
          expirationYear:(NSInteger)cardYear
            andCVVNumber:(NSString *)cardCVV;
- (id)initWithSwipeDictionary:(NSDictionary *)swipeDictionary;
- (BOOL)isNumberValid;
- (BOOL)isExpirationDateValid;
- (BOOL)isCVVValid;
- (void)chargeCardWithParameters:(NSDictionary *)chargeDictionary
                         success:(void(^)(CFTCharge *charge))success
                         failure:(void(^)(NSError *error))failure;

@end
