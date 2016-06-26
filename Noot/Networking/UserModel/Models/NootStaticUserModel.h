//
//  NootStaticUserModel.h
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NootUserModel.h"

@interface NootStaticUserModel : NSObject

@property(nonatomic, nullable)NootUserModel *userModel;

+ (nonnull instancetype)currentUser;
- (void)updateWithPersistedUser;
- (void)updateUserModelWithUserModel:(nonnull NootUserModel *)model;
- (void)resetUserModel;

@end