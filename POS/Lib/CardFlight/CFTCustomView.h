//
//  CFTCustomEntryView.h
//  CardFlightLibrary
//
//  Created by Paul Tower on 11/13/13.
//  Copyright (c) 2013 CardFlight Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFTCard;
@class CFTCustomEntryTextField;

@interface CFTCustomView : UIView

@property (nonatomic) CFTCustomEntryTextField *cardNumber;
@property (nonatomic) CFTCustomEntryTextField *expirationDate;
@property (nonatomic) CFTCustomEntryTextField *cvvNumber;

- (id)initWithoutCVVField;
- (id)initWithCVVField;
- (CFTCard *)generateCard;

@end
