//
//  LoginView.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginView;

@protocol LoginViewDelegate <NSObject>

- (void)didLoginWithFacebook:(__weak LoginView *)LoginView;

@end

@interface LoginView : UIView

@property (nonatomic, weak)id<LoginViewDelegate> delegate;

@end