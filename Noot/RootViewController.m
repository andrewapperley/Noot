//
//  RootViewController.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "UIImage+Fullscreen.h"

@interface RootViewController() <LoginViewControllerDelegate> {
    __block UIViewController *currentController;
}

@end

@implementation RootViewController

/*
 * Still don't know what I would use the delegate for
 */
- (instancetype)initWithDelegate {
    if (self = [super init]) {
        [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage fullscreenImageNamed:@"LaunchImage"]]];
        /**
         * Check for logged in state and either display login screen or main friends list
         */
        currentController = (UIViewController *)[[LoginViewController alloc] initWithDelegate:self];
        [self addChildViewController:currentController];
        [self.view addSubview:currentController.view];
    }
    return self;
}

#pragma - Mark LoginViewControllerDelegate -

- (void)didLoginSuccessfully:(LoginViewController *__weak)LoginViewController {
    [UIView animateWithDuration:0.4f animations:^{
        currentController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [currentController removeFromParentViewController];
        [currentController.view removeFromSuperview];
        currentController = nil;
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end