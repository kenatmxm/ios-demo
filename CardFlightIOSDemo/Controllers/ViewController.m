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
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"Server Response: %@", jsonDict);
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
        NSMutableDictionary *transaction = [NSMutableDictionary dictionary];       
        [transaction setObject:descriptionTextField.text forKey:@"description"];
        [transaction setObject:[NSNumber numberWithFloat:priceTextField.text.floatValue] forKey:@"amount"];
        [transaction setObject:currencyTextField.text forKey:@"currency"];
        
        [[CardFlight sharedInstance] processPaymentWithTransaction:transaction];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"CardFlight" message:@"Please enter an amount before processing payment!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
    }
   
}

- (IBAction)getSerial:(id)sender {
    NSString *serialNumber = [[CardFlight sharedInstance] getReaderSerialNumber];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:serialNumber message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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
    [[CardFlight sharedInstance] setApiToken:@"4fb831302debeb03128c5c23633a5b42" accountToken:@"c10aa9a847b55d87" andDelegate:self];
    
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
