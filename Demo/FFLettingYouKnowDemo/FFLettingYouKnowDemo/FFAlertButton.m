//
//  AlertButton.m
//  FFiSDK
//
//  Created by Igor Matyushkin on 18.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import "FFAlertButton.h"

@interface FFAlertButton ()

@end

@implementation FFAlertButton

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title tapHandler:(void (^)(void))tapHandler
{
    self = [self init];
    
    if(self)
    {
        _title = title;
        _tapHandler = [tapHandler copy];
    }
    
    return self;
}

#pragma mark Property accessors

#pragma mark Public methods

- (void)performTapHandler
{
    if(_tapHandler)
    {
        _tapHandler();
    }
}

#pragma mark Private methods

#pragma mark Delegate methods

@end
