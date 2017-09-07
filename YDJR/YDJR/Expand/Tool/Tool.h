//
//  Tool.h
//  CTTX
//
//  Created by 吕利峰 on 16/4/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CommonCrypto/CommonDigest.h>
@class SysHeadModel;
@interface Tool : NSObject
/*
 *拼接请求报文头
 */
+ (NSMutableDictionary *)backSysHeadDicWithTransServiceCode:(NSString *)TransServiceCode Contrast:(NSDictionary *)Contrast;
/*
 *获取设备的UDID
 */
+ (NSString *)getUdidCode;
/**
 *  获取时间搓
 *
 *  @return 返回16位的时间搓
 */
+ (NSString *)getTimeStr;
/*
 *获取当前时间
 */
+ (NSString *)getTimeFormatStr;
/*
 *把Json对象转化成json字符串
 */
+ (NSString *)JSONString:(NSDictionary *)detailDic;
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 把数组转换成字符串
 
 @param detailArr 数组
 @return 转换后的字符串
 */
+ (NSString *)JSONArrToString:(NSArray *)detailArr;
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
/**
 归档
 
 @param objectArr 归档数组
 @param fileName 文件名
 */
+ (void)archiverWithObjectArr:(NSArray *)objectArr fileName:(NSString *)fileName;

/**
 反归档
 
 @param fileName 文件名
 @return 数组
 */
+ (NSArray *)unarcheiverWithfileName:(NSString *)fileName;
/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
/**
 @method 获取指定宽度情况ixa，字符串value的宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param hight 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize andHight:(float)hight;
/**
 *  使用网络图片地址获取本地缓存的图片地址
 *
 *  @param imageurl 网络图片地址
 *
 *  @return 本地图片地址
 */
+ (NSString *)getImagePathWithImageURL:(NSString *)imageurl;
/**
 *  判断图片是否存在
 *
 *  @param imagePath 图片路径
 *
 *  @return 是否存在
 */
+ (BOOL)isExistWithImagePath:(NSString *)imagePath;

/**
 *  获取IP地址
 *
 *  @return 返回IP地址
 */
+ (NSString *)getIPAddress;

/**
 *  手机号验证
 *
 *  @param phoneNum 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)isMobileNumberWithPhoneNum:(NSString *)phoneNum;

/**
 *  身份证号验证
 *
 *  @param IdCard 身份证号
 *
 *  @return 是否是身份证号
 */
+(BOOL)checkIDCardNum:(NSString *)IdCard;

/**
 *  下载网点地址
 *
 *  @param url 下载网址
 */
+ (void)downloadFileWithUrl:(NSString *)url;
/**
 *  keychain取
 *
 *  @param key 对象的key值
 *
 *  @return 获取的对象
 */
+ (NSString *)getKeychainStringWithKey:(NSString *)key;
/**
 *  keychain存
 *
 *  @param key   要存的对象的key值
 *  @param value 要保存的value值
 */
+ (BOOL)saveKeyChainForKeyWithKey:(NSString *)key value:(NSString *)value;
/**
 *  获取用户数据字典
 *
 *  @return 返回用户数据字典
 */
+ (NSDictionary *)getUserDicKeyChainWithUserId:(NSString *)userId;
/**
 *  保存用户数据字典
 *
 *  @param userDic 要保存的用户数据字典
 */
+ (void)saveUserDicKeyChainWithUserDic:(NSDictionary *)userDic userId:(NSString *)userId;
/**
 *  sha1加密
 *
 *  @param input 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString*)sha1:(NSString*)input;

/**
 *  根据图片地址获取图片
 *
 *  @param imageUrl   图片地址
 *  @param imageBlock 用来返回图片对象
 */
+ (void)refreshCarImageWithImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage imageBlock:(void (^)(UIImage *image))imageBlock;

+(void)showAlertViewWithString:(NSString *)string withController:(UIViewController *)controller;

/**
 保存意向单传值数组
 
 @param valueArr 需要保存的意向单传值数组
 */
+ (void)saveIntentValueWithValueArr:(NSMutableArray *)valueArr;
/**
 获取意向单传值数组
 
 @return 传值的意向单数组
 */
+ (NSMutableArray *)getIntentValueArr;

/**
 数组排序
 
 @param arr 要排序的数组
 @param sort 0:从大到小,1:从小到大
 @return 排完序的数组
 */
+ (NSArray *)sortWithArr:(NSArray *)arr sort:(NSString *)sort;
/**
 判断客户类型是否是企业客户
 
 @param customerType 客户类型id
 @return 企业客户返回YES,个人客户返回NO
 */
+ (BOOL)isCustomerPersonTypeWithCustomerType:(NSString *)customerType;
/**
 获取客户类型字典项
 
 @return 客户类型字典项
 */
+ (NSMutableDictionary *)customerTypeDictionary;

/**
 *  添加设备令牌
 *
 *  @param deviceToken 设备令牌
 */
+ (void)saveDeviceToken:(NSData *)deviceToken;

/**
 获取设备令牌
 @return 设备令牌
 */
+ (NSString *)getDeviceToken;

/**
 下载消息到本地
 
 @param messageId 消息Id
 @return yes:保存成功,no:保存失败
 */
+ (BOOL)saveMessageToLocalWithMessageId:(NSString *)messageId;


/**
 缓存请求到本地
 
 @param bodyParmaValue 报文体
 @param isSendNotification 请求成功后是否需要发送通知
 @param noticeName 通知名
 @param requestMethod 请求名:POST,GET
 @return yes:缓存成功,NO:缓存失败
 */
+ (BOOL)cacheRequestToDBWithBodyParmaValue:(NSString *)bodyParmaValue isSendNotification:(BOOL)isSendNotification noticeName:(NSString *)noticeName requestMethod:(NSString *)requestMethod requestId:(NSString *)requestId;
/**
 移除request缓存
 
 @param requestId requestId
 */
+ (void)removecacheRequestWithRequestId:(NSString *)requestId;

/**
 判断身份证性别

 @param numberStr 身份证号
 @return 性别:男,女
 */
+ (NSString *)sexStrFromIdentityCard:(NSString *)numberStr;
/**
 设置显示文本
 
 @param text 标题
 @param index 颜色分割索引
 @param firstColor 标题颜色
 @param secondColor 功能标题颜色
 @return 富文本对象
 */
+ (NSMutableAttributedString *)makeText:(NSString *)text index:(NSUInteger)index firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor;

/**
 拼接文件下载地址
 
 @param imagePath 文件路径
 @return 下载文件URL
 */
+ (NSURL *)pinjieUrlWithImagePath:(NSString *)imagePath;

/**
 保存机构id数组索引

 @param index 索引值
 */
+ (void)saveMechinsIdWithIndex:(NSInteger)index;

/**
 获取当前机构ID

 @return 机构ID
 */
+ (NSString *)getMechinsId;
/**
 获取当前机构全称
 
 @return 机构全称
 */
+ (NSString *)getMechanismQName;
/**
 获取当前机构简称
 
 @return 机构简称
 */
+ (NSString *)getMechanismName;
/**
 保存品牌名数组索引
 
 @param index 索引值
 */
+ (void)savePpNameWithIndex:(NSInteger)index;

/**
 获取当前品牌名
 
 @return 品牌名
 */
+ (NSString *)getPpName;

/**
 获取www包使用地址
 
 @param indexName 加载路径
 @return 返回真实路径
 */
+ (NSString *)getWWWPackAddressWithIndexName:(NSString *)indexName;
/**
 清除缓存和cookie
 */
+ (void)cleanCacheAndCookie;
@end
