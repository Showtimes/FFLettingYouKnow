//
//  UIApplication+Navigation.h
//  FFiSDK
//
//  Created by Igor Matyushkin on 19.12.14.
//  Copyright (c) 2014 Find & Form. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Navigation)

- (UINavigationController *)FF_showNavigationControllerOfClass:(Class)navigationControllerClass withBarHidden:(BOOL)barHidden andViewController:(UIViewController *)viewController;

- (UIViewController *)FF_showViewControllerOfClass:(Class)viewControllerClass withNavigationControllerOfClass:(Class)navigationControllerClass andBarHidden:(BOOL)barHidden;

- (UIViewController *)FF_topViewController;

@end
