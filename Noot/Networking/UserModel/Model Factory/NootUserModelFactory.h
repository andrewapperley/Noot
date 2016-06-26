//
//  NootUserModelFactory.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootBaseNetworkDatasource.h"
#import "NootBaseNetworkModel.h"
#import "NootUserModel.h"

@class FBSDKProfile;

typedef void(^NootUserLoginSuccess)(NootUserModel *userModel, NootBaseNetworkModel *networkModel);

@interface NootUserModelFactory : NSObject

#pragma mark - User login / fetch user model and access token
- (void)loginUserWithSuccess:(NootUserLoginSuccess)success failure:(NootBaseNetworkFailure)failure;

#pragma mark - User logout
- (void)logoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;

@end