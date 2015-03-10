//
//  MainViewController.m
//  FFLettingYouKnowDemo
//
//  Created by Igor Matyushkin on 06.03.15.
//  Copyright (c) 2015 FindandForm. All rights reserved.
//

#import "MainViewController.h"
#import "FFLettingYouKnow.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions

- (IBAction)pop1
{
    FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:@"Test"
                                                              message:@"This is a message talking about what we need to be doing."
                                                    cancelButtonTitle:@"Ok"];
    
    FFAlertButton *secondButton = [[FFAlertButton alloc] initWithTitle:@"this is a second button title"
    tapHandler:^
    {
    }];
    
    [client addButton:secondButton];
    
    [client showWithCompletion:^(BOOL isCancelled)
    {
    }];
}

- (IBAction)pop2
{
}

- (IBAction)pop3
{
}

- (IBAction)pop4
{
}

- (IBAction)pop5
{
}

- (IBAction)pop6
{
}

- (IBAction)pop7
{
}

@end
