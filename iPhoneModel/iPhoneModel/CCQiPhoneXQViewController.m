//
//  CCQiPhoneXQViewController.m
//  iPhoneModel
//
//  Created by sundusk on 2018/3/12.
//  Copyright © 2018年 sundusk. All rights reserved.
//  手机显示的版本号 电量 网络状态

#import "CCQiPhoneXQViewController.h"
#import <Masonry.h>
#import <sys/utsname.h>
#import <AFNetworking.h>

@interface CCQiPhoneXQViewController ()

@end

@implementation CCQiPhoneXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];

    [self setup];
    
    
    
}
- (void)setup{
    UILabel *phoneVersionLabel = [[UILabel alloc]init];
    UILabel *phoneModelLabel = [[UILabel alloc]init];
    UILabel *iphoneMLabel = [[UILabel alloc]init];
    UILabel *batterylevelLabel = [[UILabel alloc]init];//手机剩余电量
    UILabel *batterylevelStateLabel = [[UILabel alloc]init]; // 电量状况
    UILabel *networkStateLabel = [[UILabel alloc]init];// 网络状态
    [self.view addSubview:phoneModelLabel];
    [self.view addSubview:phoneVersionLabel];
    [self.view addSubview:iphoneMLabel];
    [self.view addSubview:batterylevelLabel];
    [self.view addSubview:batterylevelStateLabel];
    [self.view addSubview:networkStateLabel];
    
    
    //1.手机系统版本：10.3
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString* one = [@"手机版本号：" stringByAppendingString:phoneVersion];
    phoneVersionLabel.text = one;
    //2.手机类型：iPhone 6
    
    NSString* phoneModel = [self iphoneType];//方法在下面
    NSString* two = [@"手机型号：" stringByAppendingString:phoneModel];
    phoneModelLabel.text = two;
    //3.手机系统：iPhone OS
    
    NSString * iphoneM = [[UIDevice currentDevice] systemName];
    NSString* three = [@"手机系统：" stringByAppendingString:iphoneM];
    iphoneMLabel.text = three;
    
    //4.电池电量
    
    //打开电池的监听
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    
    //获取电池的状态
    
    UIDeviceBatteryState BatteryState = [UIDevice currentDevice].batteryState;
    
    //获取剩余电量 范围在0.000000 至 1.000000之间
    
    CGFloat batterylevel = [UIDevice currentDevice].batteryLevel;
    
    
    
    //battery的状态  [UIDevice currentDevice].batteryState分为
    
    
    // UIDeviceBatteryStateUnknown,     未知
    
    // UIDeviceBatteryStateUnplugged,   // 未充电
    
    // UIDeviceBatteryStateCharging,     // 正在充电
    
    // UIDeviceBatteryStateFull,             // 满电
    if (BatteryState == UIDeviceBatteryStateUnknown) {
        
        batterylevelStateLabel.text = @"电量状态：未知状态";
        
    }else{
        
        
        
        //将剩余的电量用label显示。
        
        batterylevelLabel.text = [NSString stringWithFormat:@"剩余电量： %f",batterylevel];
        if (BatteryState == UIDeviceBatteryStateUnplugged) {
            batterylevelStateLabel.text = @"电量状态：未充电";
        }
        if (BatteryState == UIDeviceBatteryStateCharging) {
            batterylevelStateLabel.text = @"电量状态：正在充电";
        }
        if (BatteryState == UIDeviceBatteryStateFull) {
            batterylevelStateLabel.text = @"电量状态：满电";
        }
        
    }
    
    //
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                networkStateLabel.text = @"未知网络";
                break;
            case 0:
                NSLog(@"网络不可用");
                networkStateLabel.text = @"网络不可用";
                break;
            case 1:
            {
                NSLog(@"GPRS网络");
                networkStateLabel.text = @"正在使用移动网路";
                //发通知，带头搞事
                [[NSNotificationCenter defaultCenter] postNotificationName:@"monitorNetworking" object:@"1" userInfo:nil];
            }
                break;
            case 2:
            {
                NSLog(@"wifi网络");
                networkStateLabel.text = @"正在使用WiFi";
                //发通知，搞事情
                [[NSNotificationCenter defaultCenter] postNotificationName:@"monitorNetworking" object:@"2" userInfo:nil];
            }
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"有网");
        }else{
            NSLog(@"没网");
        }
    }];
   
    // 布局
    [phoneModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        
    }];
    [phoneVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(phoneModelLabel).offset(20);

    }];
    [iphoneMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(phoneModelLabel).offset(-20);

    }];
    [batterylevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(phoneVersionLabel ).offset(20);

    }];
    [batterylevelStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(batterylevelLabel).offset(20);
    }];
    [networkStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(iphoneMLabel).offset(-20);
    }];
//
    
    
    
    
    
}



- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}


@end
