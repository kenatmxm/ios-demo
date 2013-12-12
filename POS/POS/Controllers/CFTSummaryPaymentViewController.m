//
//  SummaryPaymentViewController.m
//  POS
//
//  Created by Tim Saunders on 11/9/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTSummaryPaymentViewController.h"
#import "CFTTransaction.h"
#import "CFTSignatureViewController.h"
#import "CFTConfirmationViewController.h"
#import "CFTCustomView.h"
#import "CFTCustomEntryTextField.h"
#import "CFTCard.h"
#import "SVProgressHUD.h"

@interface CFTSummaryPaymentViewController ()

@property (nonatomic) CFTTransaction *transaction;
@property (nonatomic) CFTCustomView *customView;
@property (nonatomic) CFTReader *reader;
@property (nonatomic) CFTCard *card;

@end

@implementation CFTSummaryPaymentViewController

#pragma mark - Init Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTransaction:(CFTTransaction *)newTransaction {
    
    self = [super init];
    if (self) {
        _transaction = newTransaction;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:[_transaction amountAsString]];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleTap];
    
    _reader = [[CFTReader alloc] initAndConnect];
    // [SVProgressHUD showWithStatus:@"Connecting Reader" maskType:SVProgressHUDMaskTypeClear];
    [_reader setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    _customView = [[CFTCustomView alloc] initWithoutCVVField];
    [_customView setFrame:self.view.frame];
    [self.view addSubview:_customView];
    
    [_customView.cardNumber customFieldFrame:CGRectMake(20, 176, 280, 40)];
    [_customView.cardNumber customFieldPlaceholder:@"Card Number"];
    [_customView.cardNumber customFieldFont:[UIFont systemFontOfSize:14]];
    [_customView.cardNumber customFieldKeyboardAppearance:UIKeyboardAppearanceDark];
    [_customView.cardNumber customFieldBorderStyle:UITextBorderStyleRoundedRect];
    
    [_customView.expirationDate customFieldFrame:CGRectMake(20, 224, 280, 40)];
    [_customView.expirationDate customFieldPlaceholder:@"Expiration Date"];
    [_customView.expirationDate customFieldFont:[UIFont systemFontOfSize:14]];
    [_customView.expirationDate customFieldKeyboardAppearance:UIKeyboardAppearanceDark];
    [_customView.expirationDate customFieldBorderStyle:UITextBorderStyleRoundedRect];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // [_reader disconnect];
}

#pragma mark - Reader Delegate

- (void)readerResponse:(CFTCard *)card withError:(NSError *)error {
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CardFlight"
                                                        message:error.localizedDescription
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        _card = card;
        [_nameTextField setText:card.name];
        [_customView.cardNumber customFieldText:card.encryptedCardNumber];
        [_customView.expirationDate customFieldText:[NSString stringWithFormat:@"%i/%i", card.expirationMonth, card.expirationYear]];
    }
}

- (void)readerIsConnecting {
    
    [SVProgressHUD showWithStatus:@"Connecting Reader" maskType:SVProgressHUDMaskTypeClear];
}

- (void)readerIsConnected:(BOOL)isConnected withError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    if (isConnected) {
        [_reader beginSwipeWithMessage:@"Swipe card now"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CardFlight"
                                                        message:error.localizedDescription
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - IB Actions

- (IBAction)chargeCard:(id)sender {
    
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Details"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:nil
                                                                              action:nil]];
    
    if (!_card) {
        _card = [_customView generateCard];
    }
    
    CFTSignatureViewController *signatureVC = [[CFTSignatureViewController alloc] initWithTransaction:_transaction];
    [signatureVC setCard:_card];
    [self.navigationController pushViewController:signatureVC animated:YES];
}

- (IBAction)retryCardSwipe:(id)sender {
    
    [_reader beginSwipeWithMessage:@"Swipe Card"];
}

#pragma mark - Private Methods

- (void)dismissKeyboard {
    
    [_nameTextField resignFirstResponder];
    [_customView.cardNumber customFieldResignFirstResponder];
    [_customView.expirationDate customFieldResignFirstResponder];
}

@end
