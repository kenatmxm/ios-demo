//
//  ViewController.m
//  CardFlightIOSDemo
//
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation ViewController

@synthesize priceTextField;
@synthesize currencyTextField;
@synthesize descriptionTextField;
@synthesize nameTextField;
@synthesize numberTextField;
@synthesize expDateTextField;
@synthesize scrollView;


#pragma mark - UITextFieldDelegate - used to adjust scroll view when keyboard is visible

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height - 216);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height + 216);
}

#pragma mark - CardFlight Delegate

//Response from CardFlight Swipe - also returns errors regarding the CardFlight dongle
-(void)swipeResponse:(NSData *)data andError:(NSError *)error
{
    if (!error)
    {
        NSDictionary *myDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        nameTextField.text = [myDict objectForKey:@"name"];
        numberTextField.text = [myDict objectForKey:@"card number"];
        expDateTextField.text = [NSString stringWithFormat:@"%@/%@", [myDict objectForKey:@"exp month"], [myDict objectForKey:@"exp year"]];        
    }
    else
    {
        //Error management goes here
    }
}

//Response after manual entry
-(void)manualEntryDictionary:(NSDictionary *)dictionary
{
    nameTextField.text = [dictionary objectForKey:@"name"];
    numberTextField.text = [dictionary objectForKey:@"number"];
    expDateTextField.text = [NSString stringWithFormat:@"%@/%@", [dictionary objectForKey:@"expiration month"], [dictionary objectForKey:@"expiration year"]];
}

//Server response after submitting data
-(void)serverResponse:(NSData *)response andError:(NSError *)error
{
    //Manage the CardFlight API server response
}

#pragma mark - CardFlight commands

- (IBAction)swipeCard:(id)sender
{
    [priceTextField resignFirstResponder];
    
    //Start swipe
    [[CardFlight sharedInstance] beginSwipeWithDefaultDialog:YES];
   
}

- (IBAction)manualEntry:(id)sender
{
    //Open keyed-entry view
    [[CardFlight sharedInstance] startKeyedEntry];

}

- (IBAction)sendSwipeData:(id)sender
{
    
    if (priceTextField.text.floatValue)
    {
        //Process payment
        //[[CardFlight sharedInstance] processPaymentWithDefaultDialog:YES andAmount:priceTextField.text.floatValue];
        NSMutableDictionary *transaction = [NSMutableDictionary dictionary];
        NSString *description = descriptionTextField.text;
        NSString *currency = currencyTextField.text;
        NSNumber *amount = [NSNumber numberWithFloat:2.3];
        
        [transaction setObject:description forKey:@"description"];
        [transaction setObject:amount forKey:@"amount"];
        [transaction setObject:currency forKey:@"currency"];
        [[CardFlight sharedInstance] processPaymentWithTransaction:transaction];    
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"CardFlight" message:@"Please enter an amount before processing payment!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
    }
   
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    scrollView.contentSize = self.view.frame.size;
    
    //Initialize CardFlight, set it's delegate and API and Account tokens
    [[CardFlight sharedInstance] setApiToken:@"e9cb15860f08e738b792951891d4ba4f" accountToken:@"08ff8bf670afe268" andDelegate:self];
    
    priceTextField.delegate = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    [self setPriceTextField:nil];
    [self setNameTextField:nil];
    [self setNumberTextField:nil];
    [self setExpDateTextField:nil];
    [self setScrollView:nil];
    [self setCurrencyTextField:nil];
    [self setDescriptionTextField:nil];
    [super viewDidUnload];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
