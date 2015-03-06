//
//  UIApplication+Navigation.m
//  FFiSDK
//
//  Created by Igor Matyushkin on 19.12.14.
//  Copyright (c) 2014 Find & Form. All rights reserved.
//

#import "UIApplication+Navigation.h"

@implementation UIApplication (Navigation)

#pragma mark Public methods

- (UINavigationController *)FF_showNavigationControllerOfClass:(Class)navigationControllerClass withBarHidden:(BOOL)barHidden andViewController:(UIViewController *)viewController
{
    if(![navigationControllerClass isSubclassOfClass:[UINavigationController class]])
    {
        return nil;
    }
    
    id navigationController = [[navigationControllerClass alloc] initWithRootViewController:viewController];
    ((UINavigationController *)navigationController).navigationBarHidden = barHidden;
    
    self.keyWindow.rootViewController = navigationController;
    
    return navigationController;
}

- (UIViewController *)FF_showViewControllerOfClass:(Class)viewControllerClass withNavigationControllerOfClass:(Class)navigationControllerClass andBarHidden:(BOOL)barHidden
{
    if(![viewControllerClass isSubclassOfClass:[UIViewController class]])
    {
        return nil;
    }
    
    id viewController = [[viewControllerClass alloc] init];
    
    if(![navigationControllerClass isSubclassOfClass:[UINavigationController class]])
    {
        return nil;
    }
    
    id navigationController = [[navigationControllerClass alloc] initWithRootViewController:viewController];
    ((UINavigationController *)navigationController).navigationBarHidden = barHidden;
    
    self.keyWindow.rootViewController = navigationController;
    
    return viewController;
}

- (UIViewController *)FF_topViewController
{
    id viewController = self.keyWindow.rootViewController;
    
    if([viewController isKindOfClass:[UINavigationController class]])
    {
        viewController = ((UINavigationController *)viewController).topViewController;
        
        UIViewController *presentedViewController = ((UIViewController *)viewController).presentedViewController;
        
        if(presentedViewController)
        {
            if([presentedViewController isKindOfClass:[UINavigationController class]])
            {
                viewController = ((UINavigationController *)presentedViewController).topViewController;
            }
            else
            {
                viewController = presentedViewController;
            }
        }
    }
    
    return viewController;
}

#pragma mark Private methods

@end
