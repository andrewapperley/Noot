//
//  NootBaseNetworkDatasource.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <AFNetworking.h>
#import "NootBaseNetworkDatasource.h"

const NSString *kNootBaseNetworkKeyPostParam            = @"params";
const NSString *kNootBaseNetworkKeyTimestampParam       = @"request_timestamp";
const NSString *kNootBaseNetworkKeyHardwareInfoParam    = @"hardware_info";

@implementation NootBaseNetworkDatasource

- (NSURLSessionDataTask *)makeURLRequestWithType:(NootNetworkCallType)type endpointURLString:(NSString *)urlString success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    return [self makeURLRequestWithType:type endpointURLString:urlString parameters:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)makeURLRequestWithType:(NootNetworkCallType)type endpointURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(NootBaseNetworkSuccess)success failure:(NootBaseNetworkFailure)failure {
    
    //Base request URL
    static AFHTTPSessionManager *sessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                
        NSURL *baseRequestURL = [NSURL URLWithString:[NSProcessInfo processInfo].environment[@"BASE_URL"]];
        if (!baseRequestURL) {
            [NSURL URLWithString:@"http://192.168.1.5:8000"];
        }
        //Create session manager
        sessionManager        = [[AFHTTPSessionManager alloc] initWithBaseURL:baseRequestURL];
    });
    
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers]];
    
    if (!parameters) {
        parameters = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *newParamDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [newParamDictionary setObject:[NSString stringWithFormat:@"%ld", ((long)[[NSDate date] timeIntervalSince1970])] forKey:kNootBaseNetworkKeyTimestampParam];
    [newParamDictionary setObject:@{
                                    @"name": [[UIDevice currentDevice] name],
                                    @"model": [[UIDevice currentDevice] model],
                                    @"systemVersion": [[UIDevice currentDevice] systemVersion]
                                    
                                    } forKey:kNootBaseNetworkKeyHardwareInfoParam];
    parameters = newParamDictionary;
    
    //If the type is "POST" then we must wrap any parameters in a 'params' dictionary.
    if(type == kNootNetworkCallType_POST) {
        
        NSMutableDictionary *newParamDictionary = [NSMutableDictionary dictionary];
        if(parameters) {
            [newParamDictionary setObject:parameters forKey:kNootBaseNetworkKeyPostParam];
        }
        
        [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
        
        return [sessionManager POST:urlString parameters:newParamDictionary progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NootBaseNetworkModel *networkModel = [NootBaseNetworkModel networkModelFromResponse:responseObject];
            success(networkModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
        
    } else {
        
        return [sessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NootBaseNetworkModel *networkModel = [NootBaseNetworkModel networkModelFromResponse:responseObject];
            success(networkModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

@end
