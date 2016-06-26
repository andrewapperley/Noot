//
//  NootListViewController.h
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NootListViewController;

@protocol NootListViewControllerDelegate <NSObject>

@end

@interface NootListViewController : UIViewController

@property (nonatomic, weak)id<NootListViewControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<NootListViewControllerDelegate>)delegate;

@end