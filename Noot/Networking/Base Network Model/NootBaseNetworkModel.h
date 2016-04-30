//
//  NootBaseNetworkModel.h
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NootBaseNetworkModel : NSObject

@property (nonatomic) BOOL success;
@property (nonatomic) NSUInteger responseCode;
@property (nonatomic, copy, readonly) NSString *responseMessage;
@property (nonatomic, copy, readonly) NSDictionary *responseData;

+ (NootBaseNetworkModel *)networkModelFromResponse:(id)callbackObject;

@end
