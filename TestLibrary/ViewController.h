//
//  ViewController.h
//  CardFlightIOSDemo
//
//  Copyright (c) 2013 CardFlight. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CardFlight.h"

@interface ViewController : UIViewController <CardFlightDelegate, UITextFieldDelegate>

- (IBAction)swipeCard:(id)sender;
- (IBAction)manualEntry:(id)sender;
- (IBAction)sendSwipeData:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
