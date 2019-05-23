//
//  BaseViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "BaseViewController.h"
#import "LifeThemeNavigationController.h"
#import "UINavigationBar+ApplyTheme.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    self.navigationSetup = ^(LifeNavigationTheme *theme) {
        if ([weakSelf.navigationController isKindOfClass:[LifeThemeNavigationController class]]) {
            LifeThemeNavigationController *themeNavigationController = weakSelf.navigationController;
            themeNavigationController.statusBarStyle = theme.statusBarStyle;
            [themeNavigationController.navigationBar applyTheme:theme];
        }
    };
    self.navigationSetup([[LifeNavigationTheme alloc]
                          initWithTintColor:[UIColor whiteColor]
                          barColor:[UIColor colorWithRed:60.0f/255.0f
                                                   green:0.0f/255.0f
                                                    blue:142.0f/255.0f
                                                   alpha:1.0f]
                          titleAttributes:@{
                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            }]);
}

@end
