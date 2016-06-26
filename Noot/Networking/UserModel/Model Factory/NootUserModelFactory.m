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
#import "NootStaticUserModel.h"

@implementation NootUserModelFactory

#pragma mark - User login
- (void)loginUserWithSuccess:(NootUserLoginSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me?fields=email,name,id" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id meResult, NSError *error) {
             if (error) {
                 return failure(error);
             }
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/picture?fields=url&type=large&redirect=false" parameters:nil]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id pictureResult, NSError *error) {
                  if (error) {
                      return failure(error);
                  }
                  NootUserModelDatasource *dataSource = [[NootUserModelDatasource alloc] init];
                  [dataSource postLoginUserWithFacebookProfile:[FBSDKProfile currentProfile] andEmail:meResult[@"email"] andProfileImage:pictureResult[@"data"][@"url"] success:^(NootBaseNetworkModel *networkCallback) {
                      
                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                          
                          NootUserModel *model;
                          
                          if(networkCallback.success) {
                              model = [NootUserModelFactory userModelForData:networkCallback.responseData];
                              [[NootStaticUserModel currentUser] updateUserModelWithUserModel:model];
                          }
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              success(model, networkCallback);
                          });
                      });
                      
                  } failure:^(NSError *error) {
                      
                      failure(error);
                  }];
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
    data = data[@"data"];
    NSDictionary *userDictionary = data[@"user"];
    NSDictionary *sessionDictionary = data[@"session"];
    
    //User info
    id userIdValue = userDictionary[@"userID"];
    
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
    
    [model setValue:userDictionary[@"profileImage"] forKey:@"userImageUrl"];
    [model setValue:userDictionary[@"name"] forKey:@"displayName"];
    [model setValue:userDictionary[@"email"] forKey:@"emailAddress"];
    [model setValue:sessionDictionary[@"token"] forKey:@"accessToken"];
    [model setValue:sessionDictionary[@"expiry"] forKey:@"expiry"];

    
    return model;
}

@end
