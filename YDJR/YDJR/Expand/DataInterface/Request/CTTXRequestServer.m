//
//  CTTXRequestServer.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/4.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
@implementation CTTXRequestServer
+ (instancetype)shareInstance
{
    static CTTXRequestServer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CTTXRequestServer alloc]init];
    });
    return instance;
}
- (void)AFNetworkStatu:(void (^)(AFNetworkReachabilityStatus statu))statu
{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                statu(AFNetworkReachabilityStatusUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                statu(AFNetworkReachabilityStatusNotReachable);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                statu(AFNetworkReachabilityStatusReachableViaWWAN);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                statu(AFNetworkReachabilityStatusReachableViaWiFi);
                break;
                
            default:
                break;
        }
        
    }] ;
}

@end
