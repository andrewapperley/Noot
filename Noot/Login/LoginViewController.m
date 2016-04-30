//
//  LoginViewController.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "NootUserModelDatasource.h"

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

#pragma mark - LoginViewDelegate -

- (void)didLoginWithFacebook:(LoginView *__weak)LoginView {
    NootUserModelDatasource *datasource = [[NootUserModelDatasource alloc] init];
    [datasource postLoginUserWithSuccess:^(NootBaseNetworkModel *networkCallback) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end