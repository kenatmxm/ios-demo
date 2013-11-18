//
//  CFTMainViewController.m
//  POS
//
//  Created by Paul Tower on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTMainViewController.h"
#import "CFTSummaryPaymentViewController.h"
#import "CFTTransaction.h"

@interface CFTMainViewController ()

@property (nonatomic) CFTTransaction *transaction;

@end

@implementation CFTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// [self setTitle:@"CardFlight"];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardFlightLogo"]];
    [self.navigationItem setTitleView:titleView];
    
    [self.amountTextField setDelegate:self];
    [self.descriptionTextField setDelegate:self];
    [self.amountTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)]];
    [self.amountTextField setLeftViewMode:UITextFieldViewModeAlways];
    [self.descriptionTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)]];
    [self.descriptionTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)swipeCardPressed:(id)sender {
    
    if ([self.amountTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops"
                                                        message:@"You must enter an amount"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (!self.transaction) {
        self.transaction = [[CFTTransaction alloc] init];
    }
    
    [self.transaction setAmount:[NSDecimalNumber decimalNumberWithString:self.amountTextField.text]];
    [self.transaction setDescriptionText:self.descriptionTextField.text];
    
    CFTSummaryPaymentViewController *summaryVC = [[CFTSummaryPaymentViewController alloc] initWithTransaction:_transaction];
    [self.navigationController pushViewController:summaryVC animated:YES];
    
    // [[CardFlight sharedInstance] beginSwipeWithDefaultDialog:YES];
}

#pragma mark - UITextfield Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 0) {
        [self.currencyLabel setText:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 0 && [textField.text isEqualToString:@""]) {
        [self.currencyLabel setText:@""];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *arrayOfString = [newString componentsSeparatedByString:@"."];
    
    // NSLog(@"Array count %i", [arrayOfString count]);
    if ([arrayOfString count] > 2 ) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Private Methods

- (void)dismissKeyboard {
    
    [self.amountTextField resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
}

@end
