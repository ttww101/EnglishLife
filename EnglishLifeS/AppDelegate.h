#import <UIKit/UIKit.h>
#import "RESideMenu.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate,JPUSHRegisterDelegate>{
    NSString *idfa;
    NSData *gheikcmaeoxqpopupRawJSON;
    BOOL gheikcmaeoxqisFirstStart;
    NSMutableDictionary *gheikcmaeoxqclientIDFAInfo;
    BOOL gheikcmaeoxqgoogleAdSwitch;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RESideMenu *gheikcmaeoxqsideMenuViewController;
@property (strong, nonatomic) NSString *idfa;
@property (strong, nonatomic) NSData *gheikcmaeoxqpopupRawJSON;
@property (nonatomic) BOOL gheikcmaeoxqisFirstStart;
@property (strong, nonatomic) NSMutableDictionary *gheikcmaeoxqclientIDFAInfo;
@property (nonatomic) BOOL gheikcmaeoxqgoogleAdSwitch;

@end
