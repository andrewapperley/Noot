//
//  NootUserModel.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootUserModel.h"

@implementation NootUserModel

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_user_id forKey:@"user_id"];
    [encoder encodeObject:_userImageUrl forKey:@"userImageUrl"];
    [encoder encodeObject:_displayName forKey:@"displayName"];
    [encoder encodeObject:_emailAddress forKey:@"emailAddress"];
    [encoder encodeObject:_accessToken forKey:@"accessToken"];
    [encoder encodeObject:_expiry forKey:@"expiry"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _user_id = [decoder decodeObjectForKey:@"user_id"];
        _userImageUrl = [decoder decodeObjectForKey:@"userImageUrl"];
        _displayName = [decoder decodeObjectForKey:@"displayName"];
        _emailAddress = [decoder decodeObjectForKey:@"emailAddress"];
        _accessToken = [decoder decodeObjectForKey:@"accessToken"];
        _expiry = [decoder decodeObjectForKey:@"expiry"];
    }
    return self;
}


@end