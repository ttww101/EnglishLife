//
//  NavigationTheme.m
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "LifeNavigationTheme.h"
#import <UIKit/UIKit.h>

@implementation LifeNavigationTheme

- (instancetype)initWithTintColor:(UIColor *)fontColor barColor:(UIColor *)barColor titleAttributes:(NSDictionary <NSAttributedStringKey, id> *)titleAttributes {
    self = [super init];
    if (self) {
        self.tintColor = fontColor;
        self.barTintColor = barColor;
        self.titleTextAttributes = titleAttributes;
    }
    return self;
}

@end
