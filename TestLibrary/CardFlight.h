//
//  CardFlight.h
//  CardFlight
//
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardFlightDelegate;

@interface CardFlight : NSObject


+(CardFlight *)sharedInstance;

//Initializes CardFlight API with API Token, Account Token and sets the delegate
-(void)setApiToken:(NSString *)cardFlightApiToken accountToken:(NSString *)cardFlightAccountToken andDelegate:(id<CardFlightDelegate>)delegate;

//Start CardFlight swipe process
-(void)beginSwipeWithDefaultDialog:(BOOL)dialog;

//Present CardFlight keyed entry view
-(void)startKeyedEntry;

//Validate data and start processing payment
-(void)processPaymentWithDefaultDialog:(BOOL)dialog andAmount:(float)amount;

//Set backgound color and navigation bar tint color in keyed entry view
-(void)setCardFlightViewControllerBackgroundColor:(id)backgroundColor andNavigationBarTintColor:(id)tintColor;

//Stop CardFlight and release all it's resources
-(void)stop;

@end



//Required Delegate Methods to notify the transaction status
@protocol CardFlightDelegate <NSObject>

//Returns data after swipe
-(void)swipeResponse:(NSData *)data andError:(NSError *)error;

//Returns data after manual entry
-(void)manualEntryDictionary:(NSDictionary *)dictionary;

//Server response
-(void)serverResponse:(NSData *)response andError:(NSError *)error;

@end