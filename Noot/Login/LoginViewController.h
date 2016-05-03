//
//  LoginViewController.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)didLoginSuccessfully:(__weak LoginViewController *)LoginViewController;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak)id<LoginViewControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<LoginViewControllerDelegate>)delegate;

@end