//
//  NootUserModelFactory.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootBaseNetworkModel.h"
#import "NootUserModel.h"
#import "NootLimitedProfileModel.h"

typedef void(^NootUserLoginSuccess)(NootUserModel *userModel, NSString *accessToken, NootBaseNetworkModel *networkCallback);
typedef void(^NootUserModelSuccess)(NootUserModel *userModel, NootBaseNetworkModel *networkCallback);
typedef void(^NootUserCreationSuccess)(NootBaseNetworkModel *networkCallback);
typedef void(^NootUserSearchSuccess)(NSArray* searchResults, NootBaseNetworkModel *networkCallback);
typedef void(^NootUserLimitedProfileSuccess)(NootLimitedProfileModel* limitedProfileModel, NootBaseNetworkModel *networkCallback);
typedef void(^NootUsernameAvailabilitySuccess)(NootBaseNetworkModel *networkCallback);
typedef void(^NootUserUpdateTokenSuccess)(NSString *accessToken, NootBaseNetworkModel *networkCallback);

@interface NootUserModelFactory : NSObject

#pragma mark - User login / fetch user model and access token
- (void)fetchUserModelAndAccessTokenWithUserName:(NSString *)userName andPassword:(NSString *)password accessToken:(NSString *)accessToken success:(NootUserLoginSuccess)success failure:(NootBaseNetworkFailure)failure;

#pragma mark - User logout
- (void)fetchLogoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;
@end