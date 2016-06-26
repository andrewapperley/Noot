//
//  NootListView.h
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NootListView;

@protocol NootListViewDelegate <NSObject>

@end

@interface NootListView : UIView

@property (nonatomic, weak)id<NootListViewDelegate> delegate;

@end