//
//  CFTConfirmationViewController.h
//  POS
//
//  Created by Kareem Grant on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFTTransaction;

@interface CFTConfirmationViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *smsTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;

- (id)initWithTransaction:(CFTTransaction *)newTransaction;
- (IBAction)sendSms:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)startNew:(id)sender;

@end
