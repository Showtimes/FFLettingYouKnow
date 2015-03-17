//
//  MainViewController.m
//  FFLettingYouKnowDemo
//
//  Created by Igor Matyushkin on 06.03.15.
//  Copyright (c) 2015 FindandForm. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewControllerItem.h"
#import "FFLettingYouKnow.h"

#define MainViewController_ReuseIdentifierForItemCell @"item-cell"

@interface MainViewController ()

@property (strong, nonatomic) NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Initialize items
    
    _items = @[
               @(MainViewControllerItemBasic),
               @(MainViewControllerItemTwo),
               @(MainViewControllerItemNoHandleBar),
               @(MainViewControllerItemFourski)
               ];
    
    
    // Initialize navigation bar
    
    self.navigationItem.title = @"FFLettingYouKnow Demo";
    
    
    // Initialize table view
    
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:MainViewController_ReuseIdentifierForItemCell];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Property accessors

#pragma mark Public methods

#pragma mark Private methods

- (NSString *)textForItem:(MainViewControllerItem)item
{
    switch(item)
    {
        case MainViewControllerItemBasic:
        {
            return @"Basic be basic";
        }
        case MainViewControllerItemTwo:
        {
            return @"Two be two";
        }
        case MainViewControllerItemNoHandleBar:
        {
            return @"No handle bars";
        }
        case MainViewControllerItemFourski:
        {
            return @"Fourski";
        }
        default:
        {
            return @"";
        }
    }
}

- (MainViewControllerItem)itemForIndex:(NSInteger)index
{
    NSNumber *itemNumber = _items[index];
    return (MainViewControllerItem)itemNumber.integerValue;
}

- (void)handleTapOnItem:(MainViewControllerItem)item
{
    switch(item)
    {
        case MainViewControllerItemBasic:
        {
            NSString *title = @"Basic Alerting";
            NSString *message = @"This is a native alert with a cancel button";
            NSString *cancelButtonTitle = @"Ok";
            
            FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:title
                                                                      message:message
                                                            cancelButtonTitle:cancelButtonTitle];
            
            [client showWithCompletion:^(BOOL isCancelled)
            {
                if(isCancelled)
                {
                    NSLog(@"cancel received!");
                }
            }];
            
            break;
        }
        case MainViewControllerItemTwo:
        {
            NSString *title = @"Two button'ed alert";
            NSString *message = @"This is convience functionality for alerts with two buttons. The cancel button infers 'OK' as its copy";
            NSString *secondButtonTitle = @"A beautiful button";
            
            FFAlertClient *client = [FFAlertClient sharedAlertClientWithImplicitCancelAndTitle:title
                                                                                       message:message
                                                                          andSecondButtonTitle:secondButtonTitle
            withSecondButtonHandler:^
            {
                NSLog(@"second button engaged!");
            }];
            
            [client showWithCompletion:^(BOOL isCancelled)
            {
                //same block as second button handler
                
                if(isCancelled)
                {
                    NSLog(@"cancelled like a champ");
                }
            }];
            
            break;
        }
        case MainViewControllerItemNoHandleBar:
        {
            NSString *message = @"Look Ma, No title!";
            NSString *cancelButtonTitle = @"Wow!";
            
            FFAlertClient *client = [FFAlertClient sharedAlertClientWithMessage:message
                                                              cancelButtonTitle:cancelButtonTitle];
            
            [client showWithCompletion:^(BOOL isCancelled)
            {
                NSLog(@"biggest wow we've ever seen. nice.");
            }];
            
            break;
        }
        case MainViewControllerItemFourski:
        {
            NSString *title = @"A Witty Title";
            NSString *message = @"with an even wittier message.. what do you think?";
            NSString *cancelButtonTitle = @"Not witty at all";
            NSString *newButtonTitle = @"The wittiest";
            NSString *newerButtonTitle = @"Somewhat witty";
            
            FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:title
                                                                      message:message
                                                            cancelButtonTitle:cancelButtonTitle];
            
            FFAlertButton *newButton = [[FFAlertButton alloc] initWithTitle:newButtonTitle
            tapHandler:^
            {
                NSLog(@"thanks—we think so too");
            }];
            
            [client addButton:newButton];
            
            FFAlertButton *newerButton = [[FFAlertButton alloc] initWithTitle:newerButtonTitle
            tapHandler:^
            {
                NSLog(@"pshht... whatever");
            }];
            
            [client addButton:newerButton];
            
            [client showWithCompletion:^(BOOL isCancelled)
            {
                if(isCancelled)
                {
                    NSLog(@"what a terrible thing to say");
                }
            }];
            
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark Actions

#pragma mark Protocol methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainViewController_ReuseIdentifierForItemCell];
    
    MainViewControllerItem item = [self itemForIndex:indexPath.row];
    cell.textLabel.text = [self textForItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath
                              animated:YES];
    
    MainViewControllerItem item = [self itemForIndex:indexPath.row];
    
    [self handleTapOnItem:item];
}

@end
