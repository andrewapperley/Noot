//
//  NootStaticUserModel.m
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootStaticUserModel.h"

static NSString *_Nonnull kNootStaticUserPersistKey = @"kNootStaticUserPersistKey";

@implementation NootStaticUserModel

+ (nonnull instancetype)currentUser {
    static NootStaticUserModel *currentUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentUser = [[NootStaticUserModel alloc] init];
    });
    return currentUser;
    
}

#pragma mark - Reset
- (void)resetUserModel {
    
    _userModel = nil;
}

#pragma mark - Setters
- (void)updateWithPersistedUser {
    _userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kNootStaticUserPersistKey]];
}

- (void)updateUserModelWithUserModel:(nonnull NootUserModel *)model {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:kNootStaticUserPersistKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _userModel = model;
}

@end