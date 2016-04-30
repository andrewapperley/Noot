//
//  NootBaseNetworkDatasource.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootBaseNetworkModel.h"

#pragma mark - Network callback block typedefs
typedef void(^NootBaseNetworkSuccess)(NootBaseNetworkModel *networkCallback);
typedef void(^NootBaseNetworkFailure)(NSError *error);

typedef NS_ENUM(NSUInteger, NootNetworkCallType) {
    kNootNetworkCallType_POST,
    kNootNetworkCallType_GET
};

@interface NootBaseNetworkDatasource : NSObject

- (NSURLSessionDataTask *)makeURLRequestWithType:(NootNetworkCallType)type endpointURLString:(NSString *)urlString success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;
- (NSURLSessionDataTask *)makeURLRequestWithType:(NootNetworkCallType)type endpointURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure;

@end
