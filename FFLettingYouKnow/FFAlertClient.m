//
//  AlertClient.m
//  FFiSDK
//
//  Created by Igor Matyushkin on 18.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import "FFAlertClient.h"
#import "FFAlertButton.h"
#import "UIApplication+Navigation.h"

@interface FFAlertClient ()

@property (strong, nonatomic) id alert;

@property (strong, nonatomic) NSMutableArray *buttons;

@property (strong, nonatomic) void (^completion)(BOOL);

@end

@implementation FFAlertClient

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        _buttons = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)sharedAlertClient
{
    static FFAlertClient *alertClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        alertClient = [[FFAlertClient alloc] init];
        [alertClient resetSettings];
    });
    
    return alertClient;
}

+ (instancetype)sharedAlertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    FFAlertClient *alertClient = [self sharedAlertClient];
    
    [alertClient resetSettings];
    
    alertClient.title = title;
    alertClient.message = message;
    alertClient.cancelButtonTitle = cancelButtonTitle;
    
    return alertClient;
}

+ (instancetype)sharedAlertClientWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    FFAlertClient *alertClient = [self sharedAlertClient];
    
    [alertClient resetSettings];
    
    alertClient.message = message;
    alertClient.cancelButtonTitle = cancelButtonTitle;
    
    return alertClient;
}

+ (instancetype)sharedAlertClientWithImplicitCancelAndTitle:(NSString *)title message:(NSString *)message andSecondButtonTitle:(NSString *)secondButtonTitle withSecondButtonHandler:(void (^)(void))secondButtonHandler
{
    FFAlertClient *alertClient = [self sharedAlertClient];
    
    [alertClient resetSettings];
    
    alertClient.title = title;
    alertClient.message = message;
    alertClient.cancelButtonTitle = FFAlertButton_CancelButtonDefaultTitle;
    
    FFAlertButton *secondButton = [[FFAlertButton alloc] initWithTitle:secondButtonTitle tapHandler:^
    {
        if(secondButtonHandler)
        {
            secondButtonHandler();
        }
    }];
    
    [alertClient addButton:secondButton];
    
    return alertClient;
}

+ (instancetype)alertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    FFAlertClient *alertClient = [[self alloc] init];
    alertClient.title = title;
    alertClient.message = message;
    alertClient.cancelButtonTitle = cancelButtonTitle;
    return alertClient;
}

#pragma mark Property accessors

#pragma mark Public methods

- (void)addButton:(FFAlertButton *)button
{
    [_buttons addObject:button];
}

- (void)removeButton:(FFAlertButton *)button
{
    [_buttons removeObject:button];
}

- (void)removeAllButtons
{
    [_buttons removeAllObjects];
}

- (void)showWithCompletion:(void (^)(BOOL))completion
{
    _completion = [completion copy];
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // Use iOS 8 SDK
        
        _alert = [UIAlertController alertControllerWithTitle:_title
                                                     message:_message
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertController *alertController = (UIAlertController *)_alert;
        
        if(_cancelButtonTitle.length > 0)
        {
            UIAlertAction *cancelButtonAction = [UIAlertAction actionWithTitle:_cancelButtonTitle
                                                                         style:UIAlertActionStyleCancel
            handler:^(UIAlertAction *action)
            {
                if(_completion)
                {
                    _completion(YES);
                    _completion = nil;
                }
            }];
            
            [alertController addAction:cancelButtonAction];
        }
        
        for(FFAlertButton *alertButton in _buttons)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:alertButton.title
                                                             style:UIAlertActionStyleDefault
            handler:^(UIAlertAction *action)
            {
                [alertButton performTapHandler];
                
                if(_completion)
                {
                    _completion(NO);
                    _completion = nil;
                }
            }];
            
            [alertController addAction:action];
        }
        
        [[UIApplication sharedApplication].FF_topViewController presentViewController:alertController
                                                                             animated:YES
                                                                           completion:nil];
    }
    else
    {
        // Use iOS 7 SDK
        
        _alert = [[UIAlertView alloc] initWithTitle:_title
                                            message:_message
                                           delegate:self
                                  cancelButtonTitle:_cancelButtonTitle
                                  otherButtonTitles:nil];
        
        UIAlertView *alertView = (UIAlertView *)_alert;
        
        for(FFAlertButton *alertButton in _buttons)
        {
            [alertView addButtonWithTitle:alertButton.title];
        }
        
        [alertView show];
    }
}

- (void)dismissAnimated:(BOOL)animated withCompletion:(void (^)(void))completion
{
    if([_alert isKindOfClass:[UIAlertView class]])
    {
        UIAlertView *alertView = (UIAlertView *)_alert;
        
        [alertView dismissWithClickedButtonIndex:-1
                                        animated:animated];
        
        if(completion)
        {
            completion();
        }
    }
    else if([_alert isKindOfClass:[UIAlertController class]])
    {
        UIAlertController *alertController = (UIAlertController *)_alert;
        
        [alertController dismissViewControllerAnimated:animated
        completion:^
        {
            if(completion)
            {
                completion();
            }
        }];
    }
}

- (UIView *)view
{
    if([_alert isKindOfClass:[UIAlertView class]])
    {
        return _alert;
    }
    else if([_alert isKindOfClass:[UIAlertController class]])
    {
        return ((UIAlertController *)_alert).view;
    }
    else
    {
        return nil;
    }
}

#pragma mark Private methods

- (void)resetSettings
{
    if([_alert isKindOfClass:[UIAlertView class]])
    {
        ((UIAlertView *)_alert).delegate = nil;
    }
    
    _alert = nil;
    
    _title = @"";
    _message = @"";
    _cancelButtonTitle = @"";
    _completion = nil;
    
    [self removeAllButtons];
}

#pragma mark Delegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    BOOL isCancelled = NO;
    
    if(buttonIndex == alertView.cancelButtonIndex)
    {
        isCancelled = YES;
    }
    else
    {
        NSInteger alertButtonIndex = buttonIndex - alertView.firstOtherButtonIndex;
        
        if((alertButtonIndex >= 0) && (alertButtonIndex < _buttons.count))
        {
            FFAlertButton *alertButton = _buttons[alertButtonIndex];
            [alertButton performTapHandler];
        }
    }
    
    if(_completion)
    {
        _completion(isCancelled);
        _completion = nil;
    }
}

@end
