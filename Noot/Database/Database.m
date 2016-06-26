//
//  Database.m
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "Database.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface Database () {
    FMDatabaseQueue *_queue;
    NSString *_databaseUrl;
}

@end

@implementation Database

+ (nonnull instancetype)sharedDatabase {
    static Database *sharedDatabase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDatabase = [[self alloc] init];
    });
    return sharedDatabase;
}

- (nonnull instancetype)init {
    if (self = [super init]) {
        _databaseUrl = [[[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] absoluteString] stringByAppendingString:@"noot.sqllite"];
        _queue = [FMDatabaseQueue databaseQueueWithPath:_databaseUrl];
    }
    return self;
}

- (void)setupDatabase {
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
    
    }];
}

@end