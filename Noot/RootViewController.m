//
//  RootViewController.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "NootListViewController.h"
#import "UIImage+Fullscreen.h"
//#import "Database.h"
#import "NootStaticUserModel.h"

@interface RootViewController() <LoginViewControllerDelegate, NootListViewControllerDelegate> {
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
        [self bootstrap];
        if ([NootStaticUserModel currentUser].userModel) {
            currentController = [[NootListViewController alloc] initWithDelegate:self];
        } else {
            currentController = [[LoginViewController alloc] initWithDelegate:self];
        }
        [self addChildViewController:currentController];
        [self.view addSubview:currentController.view];
    }
    return self;
}

#pragma mark - Bootstrap

- (void)bootstrap {
//    [[Database sharedDatabase] setupDatabase];
    [[NootStaticUserModel currentUser] updateWithPersistedUser];
}

#pragma mark - LoginViewControllerDelegate

- (void)didLoginSuccessfully:(LoginViewController *__weak)LoginViewController {
    
    [UIView animateWithDuration:0.4f animations:^{
        currentController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [currentController removeFromParentViewController];
        [currentController.view removeFromSuperview];
        currentController = [[NootListViewController alloc] initWithDelegate:self];
        [self addChildViewController:currentController];
        [self.view addSubview:currentController.view];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end