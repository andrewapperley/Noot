//
//  NootUserModelDatasource.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootBaseNetworkDatasource.h"

@class FBSDKProfile;

@interface NootUserModelDatasource : NootBaseNetworkDatasource

#pragma mark - User login
- (void)postLoginUserWithFacebookProfile:(FBSDKProfile *)profile andEmail:(NSString *)email andProfileImage:(NSString *)profileImage success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;

#pragma mark - User logout
- (void)postLogoutUserWithUserId:(NSString *)userId accessToken:(NSString *)accessToken success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;

@end