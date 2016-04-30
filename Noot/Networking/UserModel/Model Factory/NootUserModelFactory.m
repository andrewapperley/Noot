//
//  NootUserModelFactory.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootUserModelDatasource.h"
#import "NootUserModelFactory.h"

@implementation NootUserModelFactory

#pragma mark - User login / fetch user model and access token
- (void)fetchUserModelAndAccessTokenWithUserName:(NSString *)userName andPassword:(NSString *)password accessToken:(NSString *)accessToken success:(NootUserLoginSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    NootUserModelDatasource *dataSource = [[NootUserModelDatasource alloc] init];
    [dataSource postLoginUserWithSuccess:^(NootBaseNetworkModel *networkCallback) {
        
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
}

#pragma mark - User logout
- (void)fetchLogoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
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

    BOOL isDeactivated = [userDictionary[@"deactivated"] boolValue];
    model.isDeactivated = isDeactivated;
    
    return model;
}

@end
