//
//  NootUserModelDatasource.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootUserModelDatasource.h"
#import "NootUserModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

//User model endpoint
NSString *kNootUserLoginEndpointURL                     = @"/users/login";
NSString *kNootUserLogoutEndpointURL                    = @"/users/logout";

NSString *kNootUserModelParameterKeyFirstName           = @"first_name";
NSString *kNootUserModelParameterKeyLastName            = @"last_name";
NSString *kNootUserModelParameterKeyUserID              = @"user_id";
NSString *kNootUserModelParameterKeyAcessToken          = @"access_token";
NSString *kNootUserModelParameterKeyAcessTokenExpiry    = @"access_token_expiry";
NSString *kNootUserModelParameterKeyEmail               = @"email";
NSString *kNootUserModelParameterKeyProfileImage        = @"profile_image";
NSString *kNootUserModelParameterKeyDisplayName         = @"display_name";

@implementation NootUserModelDatasource

#pragma mark - User login
- (void)postLoginUserWithFacebookProfile:(FBSDKProfile *)profile andEmail:(NSString *)email success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    NSDictionary *parameters = @{
                                 kNootUserModelParameterKeyUserID: profile.userID,
                                 kNootUserModelParameterKeyDisplayName: profile.name,
                                 kNootUserModelParameterKeyEmail: email,
                                 kNootUserModelParameterKeyFirstName: profile.firstName,
                                 kNootUserModelParameterKeyLastName: profile.lastName,
                                 kNootUserModelParameterKeyAcessToken: [FBSDKAccessToken currentAccessToken].tokenString,
                                 kNootUserModelParameterKeyAcessTokenExpiry: [NSNumber numberWithInteger:[FBSDKAccessToken currentAccessToken].expirationDate.timeIntervalSince1970]
                                 };
    
    [self makeURLRequestWithType:kNootNetworkCallType_POST endpointURLString:kNootUserLoginEndpointURL parameters:parameters success:^(NootBaseNetworkModel *networkCallback) {
        success(networkCallback);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - User logout
- (void)postLogoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    NSDictionary *parameters = @{};
    
    [self makeURLRequestWithType:kNootNetworkCallType_POST endpointURLString:kNootUserLogoutEndpointURL parameters:parameters success:^(NootBaseNetworkModel *networkCallback) {
        success(networkCallback);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end