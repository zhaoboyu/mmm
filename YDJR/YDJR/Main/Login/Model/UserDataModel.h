//
//  userDataModel.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "LLFUserRoleModel.h"
@interface UserDataModel : NSObject<NSCoding>
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,assign)NSInteger logincnt;
@property (nonatomic,copy)NSString *operatorCode;//用户id/操作员ID
@property (nonatomic,copy)NSString *userName;//用户名
@property (nonatomic,copy)NSString *userDesc;//用户描述
@property (nonatomic,strong)NSMutableArray *mechanismID;//机构ID
@property (nonatomic,strong)NSMutableArray *mechanismName;//机构名称
@property (nonatomic,strong)NSMutableArray *mechanismQName;//机构全称
@property (nonatomic,strong)NSMutableArray *ppName;//汽车馆名称
@property (nonatomic,strong)NSMutableArray *roles;//角色集合
@property (nonatomic,copy)NSString *headpic;//用户头像地址
/**
 *  是否登录
 */
@property (nonatomic,assign)BOOL isLogin;//登录状态
/**
 *  是否为金融经理
 */
@property (nonatomic,assign)BOOL isFinancialManagers;//是否为金融经理-金融经理拥有该机构下所有流程的权限,销售经理只拥有录取质料的权限
+ (instancetype)sharedUserDataModel;
//清空用户数据
- (void)logOut;

- (UIInterfaceOrientationMask)interfaceOrientationMask;
@end
