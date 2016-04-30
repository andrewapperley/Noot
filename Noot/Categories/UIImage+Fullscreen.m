//
//  UIImage+Fullscreen.m
//  Noot
//
//  Created by Andrew Apperley on 2016-04-30.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "UIImage+Fullscreen.h"

@implementation UIImage (UIImage_Fullscreen)

+ (instancetype)fullscreenImageNamed:(NSString *)name {
    NSUInteger screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    NSString *suffix;
    switch (screenHeight) {
        case 568:
            suffix = @"-568h@2x";
            break;
        case 667:
            suffix = @"-667h@2x";
            break;
        case 736:
            suffix = @"-736h@3x";
            break;
        default:
            break;
    }
    NSString *imageName = [NSString stringWithFormat:@"%@%@",name, suffix];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end