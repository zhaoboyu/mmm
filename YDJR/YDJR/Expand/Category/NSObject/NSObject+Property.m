//
//  NSObject+Property.m
//  YDJR
//
//  Created by 李爽 on 2017/5/2.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

+ (void)creatPropertyCodeWithDictionary:(NSDictionary *)dict
{
	NSMutableString *strM = [NSMutableString string];
	[dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
		
		NSString *code;
		if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
			code = [NSString stringWithFormat:@"@property (nonatomic,assign) int %@;",propertyName];
		}else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
			code = [NSString stringWithFormat:@"@property (nonatomic,strong) NSArray *%@;",propertyName];
		}else if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]||[value isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]) {
			code = [NSString stringWithFormat:@"@property (nonatomic,strong) NSString *%@;",propertyName];
		}else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
			code = [NSString stringWithFormat:@"@property (nonatomic,copy) NSDictionary *%@;",propertyName];
		}else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
			code = [NSString stringWithFormat:@"@property (nonatomic,assign) BOOL %@;",propertyName];
		};
		
		[strM appendFormat:@"\n%@\n",code];
	}];
	NSLog(@"%@",strM);
}
@end
