//
//  CFTSignatureViewController.h
//  POS
//
//  Created by Paul Tower on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFTTransaction;
@class CFTCard;

@interface CFTSignatureViewController : UIViewController

@property (nonatomic) CFTCard *card;

- (id)initWithTransaction:(CFTTransaction *)newTransaction;

@end
