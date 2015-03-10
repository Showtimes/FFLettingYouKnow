//
//  ViewController.m
//  FFLettingYouKnowDemo
//
//  Created by Igor Matyushkin on 06.03.15.
//  Copyright (c) 2015 FindandForm. All rights reserved.
//

#import "ViewController.h"
#import "FFLettingYouKnow.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pop1 {
    [[FFAlertClient sharedAlertClientWithImplicitCancelAndTitle:@"Test"
                                                       message:@"This is a message talking about what we need to be doing."
                                          andSecondButtonTitle:@"this is a second button title"
                                       withSecondButtonHandler:^{
                                           NSLog(@"second BUTTON PRESSED");
                                       }] showWithCompletion:nil];
}

- (IBAction)pop2 {
}

- (IBAction)pop3 {
}

- (IBAction)pop4 {
}

- (IBAction)pop5 {
}

- (IBAction)pop6 {
}

- (IBAction)pop7 {
}

@end
