//
//  NootUserModelFactory.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootUserModelDatasource.h"
#import "NootUserModelFactory.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation NootUserModelFactory

#pragma mark - User login
- (void)loginUserWithSuccess:(NootUserLoginSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me?fields=email,name,id" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id graphResult, NSError *error) {
             if (error) {
                 return failure(error);
             }
             NootUserModelDatasource *dataSource = [[NootUserModelDatasource alloc] init];
             [dataSource postLoginUserWithFacebookProfile:[FBSDKProfile currentProfile] andEmail:graphResult[@"email"] success:^(NootBaseNetworkModel *networkCallback) {
                 
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     
                     NootUserModel *model;
                     NSString *newAccessToken;
                     NSString *expiryDate;
                     
                     if(networkCallback.success) {
                         model          = [NootUserModelFactory userModelForData:networkCallback.responseData];
                         newAccessToken = networkCallback.responseData[@"access_token"];
                         expiryDate     = networkCallback.responseData[@"expiry_date"];
                     }
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         success(model, newAccessToken, networkCallback);
                     });
                 });
                 
             } failure:^(NSError *error) {
                 
                 failure(error);
             }];
         }];
    }
}

#pragma mark - User logout
- (void)logoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    NootUserModelDatasource *dataSource = [[NootUserModelDatasource alloc] init];
    [dataSource postLogoutUserWithUserId:userId accessToken:accessToken success:^(NootBaseNetworkModel *networkCallback) {
        
        success(networkCallback);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - User model
+ (NootUserModel *)userModelForData:(NSDictionary *)data {
    
    NootUserModel *model = [[NootUserModel alloc] init];
    
    NSDictionary *userDictionary = data[@"User"];
    if (!userDictionary) {
        userDictionary = data;
    }
    
    //User info
    id userIdValue = userDictionary[@"user_id"];
    
    if(userIdValue) {
        //Check if string type
        if([userIdValue isKindOfClass:[NSString class]]) {
            [model setValue:userIdValue forKey:@"user_id"];
            
        //Check if number type
        } else if([userIdValue isKindOfClass:[NSNumber class]]) {
            NSString *userIdString = [NSString stringWithFormat:@"%ld", (long)[userIdValue integerValue]];
            [model setValue:userIdString forKey:@"user_id"];
        }
    }
    
    [model setValue:userDictionary[@"username"] forKey:@"userName"];
    [model setValue:userDictionary[@"profile_image"] forKey:@"userImageUrl"];
    [model setValue:userDictionary[@"display_name"] forKey:@"displayName"];

    
    return model;
}

@end
