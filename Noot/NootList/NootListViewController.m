//
//  NootListViewController.m
//  Noot
//
//  Created by Andrew Apperley on 2016-06-26.
//  Copyright © 2016 Andrew Apperley. All rights reserved.
//

#import "NootListViewController.h"
#import "NootListView.h"

@interface NootListViewController () <NootListViewDelegate> {
    
}

@property (nonatomic)NootListView *view;

@end

@implementation NootListViewController

@dynamic view;

- (instancetype)initWithDelegate:(id<NootListViewControllerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (void)loadView {
    self.view = [[NootListView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor yellowColor];
    self.view.alpha = 0.4f;
    self.view.delegate = self;
}
@end
