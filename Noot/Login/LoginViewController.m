//
//  LoginViewController.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "NootUserModelFactory.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <LoginViewDelegate> {
    
}

@property (nonatomic)LoginView *view;

@end

@implementation LoginViewController

@dynamic view;

- (instancetype)initWithDelegate:(id<LoginViewControllerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (void)loadView {
    self.view = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.delegate = self;
}

#pragma mark - LoginViewDelegate

- (void)didLoginWithFacebook:(LoginView *__weak)LoginView {
    typeof(self) __weak wself = self;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:wself
     handler:^(FBSDKLoginManagerLoginResult *loginResult, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (loginResult.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NootUserModelFactory *factory = [[NootUserModelFactory alloc] init];
             [factory loginUserWithSuccess:^(NootUserModel *userModel, NootBaseNetworkModel *networkModel) {
                 // Show next screen
                 LoginView.userInteractionEnabled = YES;
                 [self.delegate didLoginSuccessfully:wself];
             } failure:^(NSError *error) {
                 // Display Error
                 LoginView.userInteractionEnabled = YES;
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                 [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
                 [self presentViewController:alert animated:YES completion:nil];
            }];
         }
     }];
}

@end