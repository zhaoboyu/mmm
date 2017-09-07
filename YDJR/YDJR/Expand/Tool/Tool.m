//
//  Tool.m
//  CTTX
//
//  Created by 吕利峰 on 16/4/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "Tool.h"
#import "UploadFileRequest.h"
#import "SFHFKeychainUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "CTTXRequestServer+statusCodeCheck.h"
#import "MessageCenterViewModel.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "NSData+Encryption.h"
#import "AppDelegate.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@interface Tool ()
@property (nonatomic,strong)NSMutableDictionary *allCarMessageDic;
@end

@implementation Tool


#pragma mark 获取已绑定车辆和可缴费车辆
//拼接请求报文头
+ (NSMutableDictionary *)backSysHeadDicWithTransServiceCode:(NSString *)TransServiceCode Contrast:(NSDictionary *)Contrast
{

    NSString *timeFormatSte = [Tool getTimeFormatStr];
    //SYS_HEAD
    NSMutableDictionary *sysHeadDic = [NSMutableDictionary dictionary];
    //    [sysHeadDic setObject:@"04" forKey:@"ConsumerId"];
    [sysHeadDic setObject:TransServiceCode forKey:@"TransServiceCode"];
    NSString *salt = [Tool JSONString:Contrast];
    [sysHeadDic setObject:[salt MD5Salt] forKey:@"Contrast"];
    [sysHeadDic setObject:timeFormatSte forKey:@"TimeStamp"];
    [sysHeadDic setObject:@"01" forKey:@"PlatformType"];
    return sysHeadDic;
}

#pragma mark 获取时间搓
+ (NSString *)getTimeStr
{
    NSDate* dat = [NSDate date];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
    NSString *timeStr = [NSString stringWithFormat:@"%lf",[timeString doubleValue]*1000000];
    
    return [timeStr substringToIndex:16];
}
+ (NSString *)getTimeFormatStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:nowDate];
    //    NSLog(@"%@",dateStr);
    return dateStr;
}
//获取设备的UDID
+ (NSString *)getKeychainUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
//把Json对象转化成json字符串
+ (NSString *)JSONString:(NSDictionary *)detailDic
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:detailDic options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil || [jsonString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/**
 把数组转换成字符串
 
 @param detailArr 数组
 @return 转换后的字符串
 */
+ (NSString *)JSONArrToString:(NSArray *)detailArr
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:detailArr options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}
#pragma mark 文件归档和反归档

/**
 归档
 
 @param objectArr 归档数组
 @param fileName 文件名
 */
+ (void)archiverWithObjectArr:(NSArray *)objectArr fileName:(NSString *)fileName
{
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    NSMutableData *archiverData = [NSMutableData data];
    //创建归档工具
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:archiverData];
    //归档
    [archiver encodeObject:objectArr forKey:fileName];
    //结束归档
    [archiver finishEncoding];
    archiverData=[NSMutableData dataWithData:[archiverData AES256ParmEncryptWithKey:[NSString stringWithFormat:@"%@%@",[Tool getUdidCode],fileName]]];
    [archiverData writeToFile:filePath atomically:YES];
}
/**
 反归档
 
 @param fileName 文件名
 @return 数组
 */
+ (NSArray *)unarcheiverWithfileName:(NSString *)fileName
{
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    data=[data AES256ParmDecryptWithKey:[NSString stringWithFormat:@"%@%@",[Tool getUdidCode],fileName]];
    //将NSData通过反归档,转化成CheckViolationModel的数组对象
    NSKeyedUnarchiver *unarcheiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //通过反归档得到复杂对象数组
    NSArray *tempArr = [NSMutableArray arrayWithArray:[unarcheiver decodeObjectForKey:fileName]];
    return tempArr;
}

/**
 @method 获取指定高度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGRect r = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil];
    return r.size.height;
}
/**
 @method 获取指定宽度情况ixa，字符串value的宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param hight 限制字符串显示区域的高度
 @result float 返回的高度
 */
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize andHight:(float)hight
{
    CGRect r = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, hight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil];
    return r.size.width;
}
/**
 *  使用网络图片地址获取本地缓存的图片地址
 *
 *  @param imageurl 网络图片地址
 *
 *  @return 本地图片地址
 */
+ (NSString *)getImagePathWithImageURL:(NSString *)imageurl
{
    
    if (imageurl || imageurl.length > 0) {
        NSArray *pathArr = [imageurl componentsSeparatedByString:@"/"];
        NSString *imageName = [pathArr lastObject];
        //沙盒路径cache
        NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *imagePath = [caches stringByAppendingPathComponent:imageName];
        return imagePath;
    }else{
        return nil;
    }
}
/**
 *  判断图片是否存在
 *
 *  @param imagePath 图片路径
 *
 *  @return 是否存在
 */
+ (BOOL)isExistWithImagePath:(NSString *)imagePath
{
    NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
    BOOL isExit=[filemanage fileExistsAtPath:imagePath];
    return isExit;
}
/**
 *  获取IP地址
 *
 *  @return 返回IP地址
 */
+ (NSString *)getIPAddress
{
    
    return [self getAllIPAddress:YES];
}
#pragma mark - 手机号验证
/**
 *  手机号验证
 *
 *  @param phoneNum 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)isMobileNumberWithPhoneNum:(NSString *)phoneNum
{
    //新增
    NSString *xinMobel = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    
    //* 普通
    NSString*MOBILE=@"^(\\+86)?1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    //* 移动
    NSString*CM=@"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    //* 联通
    NSString*CU=@"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    //* 电信
    NSString*CT=@"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate*regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate*regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate*regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate*regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    NSPredicate *xinMobelPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",xinMobel];
    
    if(([xinMobelPre evaluateWithObject:phoneNum] == YES)
       ||([regextestmobile evaluateWithObject:phoneNum] ==YES)
       || ([regextestcm evaluateWithObject:phoneNum] ==YES)
       || ([regextestct evaluateWithObject:phoneNum] ==YES)
       || ([regextestcu evaluateWithObject:phoneNum] ==YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark - 身份证号验证
+(BOOL)checkIDCardNum:(NSString *)IdCard
{
    if (IdCard.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *IdCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![IdCardPredicate evaluateWithObject:IdCard]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[IdCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [IdCard substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark 添加本地通知
/**
 *  设置本地通知
 *
 *  @param alertTime 时间
 */
+ (void)registerLocalNotification:(NSInteger)alertTime notificationKeyName:(NSString *)notificationKeyName
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitYear;
    
    // 通知内容
    notification.alertBody = @"提示";
    //    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"明天是您最后的年检时间啊!" forKey:notificationKeyName];
    notification.userInfo = userDict;
    
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
// 取消某个本地推送通知
/**
 *  取消某个本地推送通知
 *
 *  @param key 通知key
 */
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}
/**
 *  下载网点地址
 *
 *  @param url 下载网址
 */
+ (void)downloadFileWithUrl:(NSString *)url
{
    UploadFileRequest *uploadFile = [[UploadFileRequest alloc]init];
    [uploadFile downloadFileWithUrl:url SuccessBlock:^(NSString *filePath) {
        NSLog(@"%@",filePath);
        NSString *codeStr = [NSString stringWithContentsOfFile:filePath encoding:(NSUTF8StringEncoding) error:nil];
        NSLog(@"%@",codeStr);
        //        [codeStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
        NSArray *oneArr = [codeStr componentsSeparatedByString:@"\r"];
        NSLog(@"%@",oneArr);
        for (NSString *tempStr in oneArr) {
            if ([tempStr isEqualToString:@""]) {
                break;
            }
            NSMutableArray *twoArr = [NSMutableArray arrayWithArray:[tempStr componentsSeparatedByString:@"|"]];
            NSLog(@"%@",twoArr);
            NSString *areaStr = [twoArr firstObject];
            if ([allDic objectForKey:areaStr]) {
                NSMutableArray *valueArr = [allDic objectForKey:areaStr];
                [valueArr addObject:twoArr];
                [allDic setObject:valueArr forKey:areaStr];
            }else{
                NSMutableArray *valueArr = [NSMutableArray array];
                [valueArr addObject:twoArr];
                [allDic setObject:valueArr forKey:areaStr];
            }
            
        }
        NSLog(@"%@",allDic);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:allDic forKey:@"addressCode"];
        
    } failedBlock:^(NSError *error) {
        
    }];
}
/**
 *  获取UUID
 *
 *  @return 获取的UUID的值
 */
+ (NSString *)getUdidCode
{
    
    if(![self getKeychainStringWithKey:@"UUID"]){
        NSString*uuid = [self getKeychainUUID];
        [self saveKeyChainForKeyWithKey:@"UUID" value:uuid];
        return uuid;
    }else{
        return [self getKeychainStringWithKey:@"UUID"];
    }
}
//keychain存取
/**
 *  keychain取
 *
 *  @param key 对象的key值
 *
 *  @return 获取的对象
 */
+ (NSString *)getKeychainStringWithKey:(NSString *)key
{
    NSError *error;
    NSString *resultStr =  [SFHFKeychainUtils getPasswordForUsername:key andServiceName:@"agree.com.cn.YDJR-llf" error:&error];
    return resultStr;
}
/**
 *  keychain存
 *
 *  @param key   要存的对象的key值
 *  @param value 要保存的value值
 */
+ (BOOL)saveKeyChainForKeyWithKey:(NSString *)key value:(NSString *)value
{
    NSError *error;
    BOOL result = [SFHFKeychainUtils storeUsername:key andPassword:value forServiceName:@"agree.com.cn.YDJR-llf" updateExisting:1 error:&error];
    if (!result) {
        NSLog(@"❌Keychain保存密码时出错：%@", error);
    }else{
        NSLog(@"✅Keychain保存密码成功！");
    }
    return result;
}
/**
 *  获取用户数据字典
 *
 *  @return 返回用户数据字典
 */
+ (NSDictionary *)getUserDicKeyChainWithUserId:(NSString *)userId
{
    NSString *userDicStr = [self getKeychainStringWithKey:USERMODEL];
    UserDataModel *userModel = [UserDataModel yy_modelWithJSON:userDicStr];
    return [userModel yy_modelToJSONObject];
}
/**
 *  保存用户数据字典
 *
 *  @param userDic 要保存的用户数据字典
 */
+ (void)saveUserDicKeyChainWithUserDic:(NSDictionary *)userDic userId:(NSString *)userId
{
    NSString *userDicStr = [self JSONString:userDic];
    [self saveKeyChainForKeyWithKey:USERMODEL value:userDicStr];
}
/**
 *  sha1加密
 *
 *  @param input 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString*)sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

/**
 *  获取IP地址
 *
 *  @param preferIPv4 是否是IPv4网络
 *
 *  @return IP地址
 */
+ (NSString *)getAllIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getAllIPAddresses];
    //    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getAllIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
/**
 *  根据图片地址获取图片
 *
 *  @param imageUrl   图片地址
 *  @param imageBlock 用来返回图片对象
 */
+ (void)refreshCarImageWithImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage imageBlock:(void (^)(UIImage *image))imageBlock
{
    
    UploadFileRequest *uploadFile = [[UploadFileRequest alloc]init];
    [uploadFile downloadImageWithUrl:imageUrl SuccessBlock:^(UIImage *image) {
        
        imageBlock(image);
    } failedBlock:^(NSError *error) {
        NSString *imagePath = [Tool getImagePathWithImageURL:imageUrl];
        UIImage *image;
        NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
        BOOL isExit=[filemanage fileExistsAtPath:imagePath];
        if(isExit==NO)
        {
            image=placeholderImage;
            
        }else{
            image = [UIImage imageWithContentsOfFile:imagePath];
            if (!image) {
                image=placeholderImage;
            }
        }
        imageBlock(image);
        //        [self.uploadCarIconButton setBackgroundImage:[UIImage imageNamed:imagePath] forState:(UIControlStateNormal)];
    }];
}

+(void)showAlertViewWithString:(NSString *)string withController:(UIViewController *)controller
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:backAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

/**
 保存意向单传值数组
 
 @param valueArr 需要保存的意向单传值数组
 */
+ (void)saveIntentValueWithValueArr:(NSMutableArray *)valueArr
{
    [Tool archiverWithObjectArr:valueArr fileName:IntentFileName];
}


/**
 获取意向单传值数组
 
 @return 传值的意向单数组
 */
+ (NSMutableArray *)getIntentValueArr
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:IntentFileName];
    NSMutableArray *intentValueArr = [NSMutableArray arrayWithArray:tempArr];
    return intentValueArr;
}

/**
 数组排序
 
 @param arr 要排序的数组
 @param sort 0:从大到小,1:从小到大
 @return 排完序的数组
 */
+ (NSArray *)sortWithArr:(NSArray *)arr sort:(NSString *)sort
{
    NSArray *keyArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSInteger int1 = [obj1 integerValue];
        NSInteger int2 = [obj2 integerValue];
        if ([sort isEqualToString:@"0"]) {
            if (int1 > int2) {
                return -1;
            }else{
                return 1;
            }
        }else{
            if (int1 > int2) {
                return 1;
            }else{
                return -1;
            }
        }
        
    }];
    return keyArr;
}

/**
 判断客户类型是否是企业客户
 
 @param customerType 客户类型id
 @return 企业客户返回YES,个人客户返回NO
 */
+ (BOOL)isCustomerPersonTypeWithCustomerType:(NSString *)customerType
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    NSArray *customerIdsTypeArr = [cardTypeDic objectForKey:@"IDFS000046"];
    if ([customerType isEqualToString:[customerIdsTypeArr[0] objectForKey:@"dictvalue"]]) {
        return YES;
        
    }else{
        return NO;
    }
}

/**
 获取客户类型字典项
 
 @return 客户类型字典项
 */
+ (NSMutableDictionary *)customerTypeDictionary
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    NSArray *customerIdsTypeArr = [cardTypeDic objectForKey:@"IDFS000046"];
    NSMutableDictionary *customerTypeDic = [NSMutableDictionary dictionary];
    [customerTypeDic setObject:[customerIdsTypeArr[0] objectForKey:@"dictvalue"] forKey:[customerIdsTypeArr[0] objectForKey:@"dictname"]];
    [customerTypeDic setObject:[customerIdsTypeArr[1] objectForKey:@"dictvalue"] forKey:[customerIdsTypeArr[1] objectForKey:@"dictname"]];
    return customerTypeDic;
}


/**
 *  添加设备令牌
 *
 *  @param deviceToken 设备令牌
 */
+ (void)saveDeviceToken:(NSData *)deviceToken
{
    NSString *key=@"DeviceToken";
    NSString *dvsToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    //============保存dvsToken===========================
    NSString *formatToekn = [dvsToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *oldToken= [[NSUserDefaults standardUserDefaults]objectForKey:key];
    //如果偏好设置中的已存储设备令牌和新获取的令牌不同则存储新令牌并且发送给服务器端
    if (![oldToken isEqualToString:formatToekn]) {
        [[NSUserDefaults standardUserDefaults] setObject:formatToekn forKey:key];
    }
}

/**
 获取设备令牌
 @return 设备令牌
 */
+ (NSString *)getDeviceToken
{
    NSString *key=@"DeviceToken";
    NSString *oldToken= [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (!oldToken) {
        oldToken = @" ";
    }
    return oldToken;
}


/**
 下载消息到本地
 
 @param messageId 消息Id
 @return yes:保存成功,no:保存失败
 */
+ (BOOL)saveMessageToLocalWithMessageId:(NSString *)messageId
{
    [[CTTXRequestServer shareInstance] checkStatusCodeMessageWithMessageId:messageId SuccessBlock:^(MessageModel *messageModel) {
        
    } failedBlock:^(NSError *error) {
        NSMutableDictionary *objectDic = [NSMutableDictionary dictionary];
        [objectDic setObject:messageId forKey:@"messageId"];
        [objectDic setObject:@"1" forKey:@"type"];
        BOOL res;
        res = [[DBManger sharedDMManger]insertTable:queryMessageInfo withObjectDictionary:objectDic];
    }];
    
    return YES;
}
/**
 缓存请求到本地
 
 @param bodyParmaValue 报文体
 @param isSendNotification 请求成功后是否需要发送通知
 @param noticeName 通知名
 @param requestMethod 请求名:POST,GET
 @return yes:缓存成功,NO:缓存失败
 */
+ (BOOL)cacheRequestToDBWithBodyParmaValue:(NSString *)bodyParmaValue isSendNotification:(BOOL)isSendNotification noticeName:(NSString *)noticeName requestMethod:(NSString *)requestMethod requestId:(NSString *)requestId
{
    NSMutableDictionary *objectDic = [NSMutableDictionary dictionary];
    [objectDic setObject:bodyParmaValue forKey:@"bodyParmaValue"];
    if (isSendNotification) {
        [objectDic setObject:@"1" forKey:@"isSendNotification"];
    }else{
        [objectDic setObject:@"0" forKey:@"isSendNotification"];
    }
    [objectDic setObject:noticeName forKey:@"noticeName"];
    [objectDic setObject:requestMethod forKey:@"requestMethod"];
    [objectDic setObject:requestMethod forKey:@"requestId"];
    BOOL res;
    res = [[DBManger sharedDMManger]insertTable:cacheRequestInfo withObjectDictionary:objectDic];
    return res;
}

/**
 移除request缓存
 
 @param requestId requestId
 */
+ (void)removecacheRequestWithRequestId:(NSString *)requestId
{
    NSDictionary *conditions = @{@"requestId":requestId};
    [[DBManger sharedDMManger] deleteTable:cacheRequestInfo deleteByConditions:conditions];
}

/**
 判断身份证性别
 
 @param numberStr 身份证号
 @return 性别:男,女
 */
+ (NSString *)sexStrFromIdentityCard:(NSString *)numberStr
{
    NSString *result = nil;
    BOOL isAllNumber = YES;
    if([numberStr length]<17)
        return result;
    //**截取第17为性别识别符
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(16, 1)];
    //**检测是否是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    int sexNumber = [fontNumer integerValue];
    if(sexNumber%2==1)
        result = @"男";
    ///result = @"M";
    else if (sexNumber%2==0)
        result = @"女";
    //result = @"F";
    return result;
}

/**
 设置显示文本
 
 @param text 标题
 @param index 颜色分割索引
 @param firstColor 标题颜色
 @param secondColor 功能标题颜色
 @return 富文本对象
 */
+ (NSMutableAttributedString *)makeText:(NSString *)text index:(NSUInteger)index firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:firstColor] range:NSMakeRange(0,index)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:secondColor] range:NSMakeRange(index,text.length - index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(index, text.length - index)];
    return str;
}

/**
 拼接文件下载地址

 @param imagePath 文件路径
 @return 下载文件URL
 */
+ (NSURL *)pinjieUrlWithImagePath:(NSString *)imagePath
{
    NSString *urlStr = [NSString stringWithFormat:@"%@DownloadFileManager.ao?imagePath=%@",baseNetWorkURL,imagePath];
    return [NSURL URLWithString:urlStr];
}

/**
 保存机构id数组索引
 
 @param index 索引值
 */
+ (void)saveMechinsIdWithIndex:(NSInteger)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:index forKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
    [defaults synchronize];
    [self savePpNameWithIndex:0];
    //更新本地数据字典缓存
    [[AppDelegate sharedInstance] saveDicToLocal];
}

/**
 获取当前机构ID
 
 @return 机构ID
 */
+ (NSString *)getMechinsId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
    NSArray *MechinsIdArr = [UserDataModel sharedUserDataModel].mechanismID;
    NSString *MechinsId;
    if (index && index >= 0) {
        MechinsId = [MechinsIdArr[index] objectForKey:@"mechanismID"];
    }else{
        MechinsId = [MechinsIdArr[0] objectForKey:@"mechanismID"];
    }
    
    return MechinsId;
}
/**
 获取当前机构全称
 
 @return 机构全称
 */
+ (NSString *)getMechanismQName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
    NSArray *mechanismQNameArr = [UserDataModel sharedUserDataModel].mechanismQName;
    NSString *mechanismQName;
    if (index && index >= 0) {
        mechanismQName = [mechanismQNameArr[index] objectForKey:@"mechanismQName"];
    }else{
        mechanismQName = [mechanismQNameArr[0] objectForKey:@"mechanismQName"];
    }
    
    return mechanismQName;
}
/**
 获取当前机构简称
 
 @return 机构简称
 */
+ (NSString *)getMechanismName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
    NSArray *mechanismNameArr = [UserDataModel sharedUserDataModel].mechanismName;
    NSString *mechanismName;
    if (index && index >= 0) {
        mechanismName = [mechanismNameArr[index] objectForKey:@"mechanismName"];
    }else{
        mechanismName = [mechanismNameArr[0] objectForKey:@"mechanismName"];
    }
    
    return mechanismName;
}
/**
 保存品牌名数组索引
 
 @param index 索引值
 */
+ (void)savePpNameWithIndex:(NSInteger)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:index forKey:[NSString stringWithFormat:@"%@ppNameIndex",[UserDataModel sharedUserDataModel].userName]];
    [defaults synchronize];
}
/**
 获取当前品牌名
 
 @return 品牌名
 */
+ (NSString *)getPpName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
    NSArray *MechinsIdArr = [UserDataModel sharedUserDataModel].mechanismID;
    NSArray *carPpNameArr;
    if (index && index >= 0) {
        carPpNameArr = [MechinsIdArr[index] objectForKey:@"ppName"];
    }else{
        carPpNameArr = [MechinsIdArr[0] objectForKey:@"ppName"];
    }
    NSInteger ppNameIndex = [defaults integerForKey:[NSString stringWithFormat:@"%@ppNameIndex",[UserDataModel sharedUserDataModel].userName]];
    NSString *ppName;
    if (ppNameIndex && ppNameIndex >= 0) {
        ppName = [carPpNameArr[ppNameIndex] objectForKey:@"ppName"];
    }else{
        ppName = [carPpNameArr[0] objectForKey:@"ppName"];
    }
    return ppName;
}

/**
 获取www包使用地址

 @param indexName 加载路径
 @return 返回真实路径
 */
+ (NSString *)getWWWPackAddressWithIndexName:(NSString *)indexName
{
//    NSArray *localArr = [Tool unarcheiverWithfileName:DATALISTPATH];
//    NSDictionary *dataDic = localArr[0];
//    NSArray *arr = [dataDic objectForKey:@"IDFS000342"];
//    if (arr.count > 0) {
//        NSDictionary *wwwDic = arr[0];
//        NSString *wwwPackType = [wwwDic objectForKey:@"dictvalue"];
//        if (wwwPackType && [wwwPackType isEqualToString:@"01"]) {
//            NSString *wwwPackIp = [NSString stringWithFormat:@"%@www/%@",baseIP,indexName];
//            NSLog(@"llf------------------www包地址:%@",wwwPackIp);
//            return wwwPackIp;
//        }
//    }
//    NSLog(@"llf------------------www包地址:%@",indexName);
    return indexName;

}
/**清除缓存和cookie*/

/**
 清除缓存和cookie
 */
+ (void)cleanCacheAndCookie{
    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
//    //清除UIWebView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
}
@end
