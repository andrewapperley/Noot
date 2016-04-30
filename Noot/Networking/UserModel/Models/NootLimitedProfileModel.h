//
//  NootLimitedProfileModel.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NootUserModel.h"

@interface NootLimitedProfileModel : NootUserModel

@property (nonatomic) NSInteger videosCount;
@property (nonatomic) NSInteger connectionsCount;

@end