//
//  NootBaseNetworkModel.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootBaseNetworkModel.h"

@implementation NootBaseNetworkModel

#pragma mark - Status handling
+ (NootBaseNetworkModel *)networkModelFromResponse:(id)callbackObject {
    
    NSMutableDictionary *networkCallbackDictionary = callbackObject;
    
    NootBaseNetworkModel *networkModel = [[NootBaseNetworkModel alloc] init];
    
    //Status
    networkModel.success = [networkCallbackDictionary[@"status"] boolValue];
    [networkCallbackDictionary removeObjectForKey:@"status"];
    
    //Response code
    NSUInteger responseCode = [networkCallbackDictionary[@"HTTP_CODE"] unsignedIntegerValue];
    networkModel.responseCode = responseCode;
    [networkCallbackDictionary removeObjectForKey:@"HTTP_CODE"];
    
    //Response message
    NSString *responseMessage = networkCallbackDictionary[@"message"];
    [networkModel setValue:responseMessage forKey:@"responseMessage"];
    [networkCallbackDictionary removeObjectForKey:@"message"];
    
    //Response data
    NSDictionary *responseDictionary = [NSDictionary dictionaryWithDictionary:networkCallbackDictionary];
    
    if(responseDictionary && responseDictionary.allValues.count > 0 && responseDictionary.allKeys.count > 0) {
        [networkModel setValue:responseDictionary forKey:@"responseData"];
    }
    
    return networkModel;
}

@end
