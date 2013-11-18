//
//  CFTSignatureViewController.m
//  POS
//
//  Created by Paul Tower on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTSignatureViewController.h"
#import "CFTTransaction.h"
#import "CFTConfirmationViewController.h"
#import "NICSignatureView.h"
#import "CFTCard.h"
#import "CFTCharge.h"

@interface CFTSignatureViewController ()

@property (nonatomic) CFTTransaction *transaction;
@property (nonatomic) NICSignatureView *signatureView;

@end

@implementation CFTSignatureViewController

- (id)initWithTransaction:(CFTTransaction *)newTransaction {
    
    self = [super init];
    if (self) {
        _transaction = newTransaction;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:[_transaction amountAsString]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Continue", nil)
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(acceptSignature)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    _signatureView = [[NICSignatureView alloc] initWithFrame:CGRectZero context:nil];
    [self.view addSubview:_signatureView];
    [_signatureView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *layoutDict = NSDictionaryOfVariableBindings(_signatureView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[_signatureView]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:layoutDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_signatureView]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:layoutDict]];
    
    UIImageView *signatureLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signatureLine"]];
    [_signatureView addSubview:signatureLine];
    [signatureLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *signatureDict = NSDictionaryOfVariableBindings(signatureLine);
    [_signatureView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[signatureLine]-20-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:signatureDict]];
    [_signatureView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signatureLine(26)]-50-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:signatureDict]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)acceptSignature {
    
    NSDictionary *parameters = @{@"amount": _transaction.amountInCents,
                                 @"description": _transaction.descriptionText,
                                 @"currency": @"USD"};
    
    [_card chargeCardWithParameters:parameters
                            success:^(CFTCharge *charge) {
                                CFTConfirmationViewController *summary = [[CFTConfirmationViewController alloc] initWithTransaction:_transaction];
                                [self.navigationController pushViewController:summary animated:YES];
                            }
                            failure:^(NSError *error) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:error.localizedDescription
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Okay"
                                                                      otherButtonTitles:nil];
                                [alert show];
                            }];
}

- (void)doubleTap {
    
    [_signatureView erase];
}

@end
