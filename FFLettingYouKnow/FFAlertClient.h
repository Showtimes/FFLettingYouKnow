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

+ (instancetype)sharedAlertClient;

+ (instancetype)sharedAlertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (instancetype)sharedAlertClientWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

//Until variable arguments
+ (instancetype)sharedAlertClientWithImplicitCancelAndTitle:(NSString *)title message:(NSString *)message andSecondButtonTitle:(NSString *)secondButtonTitle withSecondButtonHandler:(void (^)(void))tapHandler;


+ (instancetype)alertClientWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)addButton:(FFAlertButton *)button;

- (void)removeButton:(FFAlertButton *)button;

- (void)removeAllButtons;

- (void)showWithCompletion:(void (^)(BOOL isCancelled))completion;

- (void)dismissAnimated:(BOOL)animated withCompletion:(void (^)(void))completion;

- (UIView *)view;

@end
