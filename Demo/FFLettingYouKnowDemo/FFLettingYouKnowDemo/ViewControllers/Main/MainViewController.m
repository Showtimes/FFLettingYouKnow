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
    FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:@"Basic Alerting"
                                                              message:@"This is a native alert with a cancel button"
                                                    cancelButtonTitle:@"Ok"];
    

    
    [client showWithCompletion:^(BOOL isCancelled)
    {
        if (isCancelled) {
            NSLog(@"cancel received!");
        }
    }];
}

- (IBAction)pop2
{
    
    FFAlertClient *client = [FFAlertClient sharedAlertClientWithImplicitCancelAndTitle:@"Two button'ed alert" message:@"This is convience functionality for alerts with two buttons. The cancel button infers 'OK' as its copy" andSecondButtonTitle:@"A beautiful button" withSecondButtonHandler:^{
        NSLog(@"second button engaged!");
    }];
    [client showWithCompletion:^(BOOL isCancelled) {
        if (isCancelled) {
            NSLog(@"cancelled like a champ");
        }
        //same block as second button handler
    }];
}

- (IBAction)pop3
{
    FFAlertClient *client = [FFAlertClient sharedAlertClientWithMessage:@"Look Ma, No title! " cancelButtonTitle:@"Wow!"];
    [client showWithCompletion:^(BOOL isCancelled) {
        NSLog(@"biggest wow we've ever seen. nice.");
    }];
}

- (IBAction)pop4
{
    FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:@"A Witty Title" message:@"with an even wittier message.. what do you think?" cancelButtonTitle:@"Not witty at all"];
    
    FFAlertButton *newButton = [[FFAlertButton alloc] initWithTitle:@"The wittiest" tapHandler:^{
        NSLog(@"thanks—we think so too");
    }];
    [client addButton:newButton];
    
    FFAlertButton *newerButton = [[FFAlertButton alloc] initWithTitle:@"Somewhat witty" tapHandler:^{
        NSLog(@"pshht... whatever");
    }];
    [client addButton:newerButton];
    
    [client showWithCompletion:^(BOOL isCancelled) {
        if (isCancelled) {
            NSLog(@"what a terrible thing to say");
        }
    }];
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
