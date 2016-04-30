//
//  NootUserModel.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NootUserModel : NSObject

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *user_id;
@property (nonatomic, copy, readonly) NSString *userImageUrl;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, assign) NSUInteger videoCount;
@property (nonatomic, readonly) BOOL isNewConnection;
@property (nonatomic) BOOL isDeactivated;

@end
