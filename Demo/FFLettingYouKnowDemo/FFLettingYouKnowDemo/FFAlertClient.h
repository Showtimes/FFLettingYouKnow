//
//  AlertClient.h
//  FFiSDK
//
//  Created by Igor Matyushkin on 18.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define FFAlertButton_CancelButtonDefaultTitle @"Ok"

@class FFAlertButton;

@interface FFAlertClient : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *message;

@property (strong, nonatomic) NSString *cancelButtonTitle;

/**
 It's highly recommended to use singleton object for FFAlertClient due to purposes of memory management.
 
 @return FFAlertClient singleton object with default settings.
 */
+ (instancetype)sharedAlertClient;

/**
 It's highly recommended to use singleton object for FFAlertClient due to purposes of memory management.
 
 @param title Alert's title.
 
 @param message Alert's message.
 
 @param cancelButtonTitle Title for cancel button.
 
 @return FFAlertClient singleton object with specified alert title, message and cancel button's title.
 */
+ (instancetype)sharedAlertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 It's highly recommended to use singleton object for FFAlertClient due to purposes of memory management.
 
 @param message Alert's message.
 
 @param cancelButtonTitle Title for cancel button.
 
 @return FFAlertClient singleton object with empty alert's title, specified message and cancel button's title.
 */
+ (instancetype)sharedAlertClientWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 It's highly recommended to use singleton object for FFAlertClient due to purposes of memory management.
 
 @param title Alert's title.
 
 @param message Alert's message.
 
 @param secondButtonTitle Title for second button.
 
 @param secondButtonHandler Handler for second button.
 
 @return FFAlertClient singleton object with specified alert title, message and default cancel button and additional second button.
 */
+ (instancetype)sharedAlertClientWithImplicitCancelAndTitle:(NSString *)title message:(NSString *)message andSecondButtonTitle:(NSString *)secondButtonTitle withSecondButtonHandler:(void (^)(void))secondButtonHandler;

/**
 Creates and returns new FFAlertClient object with specified alert title, message and cancel button's title.
 
 @param title Alert's title.
 
 @param message Alert's message.
 
 @param secondButtonTitle Title for second button.
 
 @param secondButtonHandler Handler for second button.
 
 @return New FFAlertClient object with specified alert title, message and cancel button's title.
 */
+ (instancetype)alertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 Adds new button to the client.
 
 @param button Button to be added to the client.
 */
- (void)addButton:(FFAlertButton *)button;

/**
 Removes specified button from the client.
 
 @param button Button to be removed from the client.
 */
- (void)removeButton:(FFAlertButton *)button;

/**
 Removes all buttons from the client.
 */
- (void)removeAllButtons;

/**
 Presents alert with specified completion block.
 
 @param completion Completion block for alert client.
 */
- (void)showWithCompletion:(void (^)(BOOL isCancelled))completion;

/**
 Dismisses alert.
 
 @param animated Shows whether alert should be dismissed animated.
 
 @param completion Completion block which is called when alert had been dismissed.
 */
- (void)dismissAnimated:(BOOL)animated withCompletion:(void (^)(void))completion;

/**
 Alert client uses UIAlertView or UIAlertController depending on system version.
 
 @return Alert view.
 */
- (UIView *)view;

@end
