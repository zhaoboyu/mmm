//
//  userDataModel.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UserDataModel.h"
static UserDataModel *userData = nil;
@implementation UserDataModel
+ (instancetype)sharedUserDataModel
{
    //这段代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userData = [[UserDataModel alloc]init];
    });
    return userData;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flag = 1;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)setRoles:(NSMutableArray *)roles{
//    if (!_roles) {
    _roles = [NSMutableArray array];
    if (roles && ![roles isEqual:@""] && roles.count > 0) {
        for (int i = 0; i < roles.count; i++) {
            NSDictionary *roleDic = roles[i];
            LLFUserRoleModel *roleModel = [LLFUserRoleModel yy_modelWithDictionary:roleDic];
            [_roles addObject:roleModel];
        }
    }else{
        _roles = nil;
    }
//    }
    
    
}
- (BOOL)isLogin{
    //获取用户信息
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN] && ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN] isEqualToString:@"1"])) {
        _isLogin = YES;
    }else{
        _isLogin = NO;
    }
    return _isLogin;
}
//清空用户数据
- (void)logOut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:LOGIN];
    [defaults setObject:@"" forKey:USERMODEL];
    [defaults synchronize];
    
    NSDictionary *dic = @{@"operatorCode":@"",@"userName":@"",@"userDesc":@"",@"mechanismID":@"",@"mechanismName":@"",@"roles":@[]};
    [self setValuesForKeysWithDictionary:dic];
}
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}
-(NSString *)description
{
    return [self yy_modelDescription];
}
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"roles" : [LLFUserRoleModel class]};
//}

- (BOOL)isFinancialManagers
{
    if (self.roles.count > 0) {
        LLFUserRoleModel *roleModel = self.roles[0];
        if ([roleModel.roleId isEqualToString:@"30"] || [roleModel.roleName isEqualToString:@"销售经理"]) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
- (UIInterfaceOrientationMask)interfaceOrientationMask {
    if (self.flag == 1) {
        return UIInterfaceOrientationMaskLandscape;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }
}
#pragma mark 私有方法
@end
