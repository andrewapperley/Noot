//
//  LoginView.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewController.h"

NSInteger ActionButtonHeight = 50;

@interface LoginView () {
    
}

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"init login view %@", NSStringFromCGRect(frame));
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.numberOfLines = 2;
    title.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Noot\nThe only way to send a Nootification"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:50.0] range:NSMakeRange(0, 4)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(5, string.length-5)];
    title.attributedText = string;
    [title sizeToFit];
    title.frame = CGRectMake(0, (self.bounds.size.height - title.bounds.size.height)/2, self.bounds.size.width, title.bounds.size.height);
    [self addSubview:title];
    
    NSAttributedString *facebookString = [[NSAttributedString alloc] initWithString:@"Login with Facebook" attributes:@{
                                                                                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0],
                                                                                                                           NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                                                           }];
    
    UIButton* facebookButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - ActionButtonHeight, self.bounds.size.width, ActionButtonHeight)];
    [facebookButton setAttributedTitle:facebookString forState:UIControlStateNormal];
    [facebookButton setBackgroundColor:[UIColor colorWithRed:109/255.0f green:132/255.0f blue:180/255.0f alpha:1]];
    [facebookButton addTarget:self action:@selector(loginWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:facebookButton];
    NSLog(@"created login button with frame: %@", NSStringFromCGRect(facebookButton.frame));
}

#pragma mark - Button Actions -
- (void)loginWithFacebook:(UIEvent *)e {
    self.userInteractionEnabled = NO;
    [self.delegate didLoginWithFacebook:self];
}

#pragma mark - Cleanup -

- (void)dealloc {
    self.delegate = nil;
}

@end