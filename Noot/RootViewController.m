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

@interface RootViewController() <LoginViewControllerDelegate>

@end

@implementation RootViewController

/*
 * Still don't know what I would use the delegate for
 */
- (instancetype)initWithDelegate {
    if (self = [super init]) {
        [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage fullscreenImageNamed:@"LaunchImage"]]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /**
     * Check for logged in state and either display login screen or main friends list
     */
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithDelegate:self];
    [self addChildViewController:loginViewController];
    [self.view addSubview:loginViewController.view];
}

@end