//
//  Database.h
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Database : NSObject

+ (nonnull instancetype)sharedDatabase;

- (void)setupDatabase;

@end