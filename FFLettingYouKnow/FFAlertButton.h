//
//  AlertButton.h
//  FFiSDK
//
//  Created by Igor Matyushkin on 18.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFAlertButton : NSObject

@property (strong, nonatomic, readonly) NSString *title;

@property (strong, nonatomic, readonly) void (^tapHandler)(void);

- (instancetype)initWithTitle:(NSString *)title tapHandler:(void (^)(void))tapHandler;

/**
 Simulates tap on the button.
 */
- (void)performTapHandler;

@end
