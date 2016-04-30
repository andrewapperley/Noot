//
//  NootUserModelDatasource.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootUserModelDatasource.h"
#import "NootUserModel.h"

//User model endpoint
NSString *kNootUserLoginEndpointURL                     = @"/users/login";
NSString *kNootUserLogoutEndpointURL                    = @"/users/logout";

NSString *kNootUserModelParameterKeyUserName            = @"username";
NSString *kNootUserModelParameterKeyUserID              = @"user_id";
NSString *kNootUserModelParameterKeyAcessToken          = @"access_token";
NSString *kNootUserModelParameterKeyEmail               = @"email";
NSString *kNootUserModelParameterKeyProfileImage        = @"profile_image";
NSString *kNootUserModelParameterKeyDisplayName         = @"display_name";

@implementation NootUserModelDatasource

#pragma mark - User login
- (void)postLoginUserWithSuccess:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    [self makeURLRequestWithType:kNootNetworkCallType_POST endpointURLString:kNootUserLoginEndpointURL parameters:nil success:^(NootBaseNetworkModel *networkCallback) {
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