//
//  EnglishData.h
//  iHealthS
//
//  Created by Apple on 2019/3/22.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DATA
@end

@interface DATA : JSONModel
@property NSString *chinese;
@property NSString *english;
@property NSString *number;

@end

@implementation DATA
@end

@interface EnglishData : JSONModel

@property NSString *status;
@property NSString *msg;
@property NSArray<DATA> *data;
//@property NSArray *data;
@end

@implementation EnglishData
@end

NS_ASSUME_NONNULL_END
