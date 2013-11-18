//
//  CFTConfirmationViewController.m
//  POS
//
//  Created by Kareem Grant on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTConfirmationViewController.h"
#import "CFTTransaction.h"
#import "CFTMainViewController.h"

@interface CFTConfirmationViewController ()

@property (nonatomic) CFTTransaction *transaction;

@end

@implementation CFTConfirmationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTransaction:(CFTTransaction *)newTransaction {
    
    if (self) {
        _transaction = newTransaction;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:[_transaction amountAsString]];
	
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:singleTap];
    
    [_descriptionLabel setText:_transaction.descriptionText];
    [_amountLabel setText:[_transaction amountAsString]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSms:(id)sender {
    NSLog(@"Send SMS Action called");
}

- (IBAction)sendEmail:(id)sender {
    NSLog(@"Send Email Action called");
}

- (IBAction)startNew:(id)sender {
 
    CFTMainViewController *mainVC = [[CFTMainViewController alloc] init];
    [self.navigationController setViewControllers:@[mainVC] animated:YES];
}

- (void) dismissKeyboard {
    [self.smsTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

@end
