//
//  CFTSummaryPaymentViewController.h
//  POS
//
//  Created by Tim Saunders on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFTReader.h"
@class CFTTransaction;

@interface CFTSummaryPaymentViewController : UIViewController <readerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (id)initWithTransaction:(CFTTransaction *)newTransaction;

- (IBAction)chargeCard:(id)sender;
- (IBAction)retryCardSwipe:(id)sender;

@end
