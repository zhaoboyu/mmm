/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  Cordova_TEST
//
//  Created by Yalin on 14-2-20.
//  Copyright Yalin 2014年. All rights reserved.
//

#import "CDVViewController.h"
#import "CDVCommandDelegateImpl.h"
#import "CDVCommandQueue.h"

@interface MainViewController : CDVViewController<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
/**
 *  意向单id
 */
@property (nonatomic, copy) NSString *intentID;

/**
 *  产品id
 */
@property (nonatomic, copy) NSString *productID;

/**
 产品属性:1:自营,2:代理,3:达分期
 */
@property (nonatomic, copy) NSString *productstate;
@property (nonatomic,assign)BOOL isHaveTop;//是否是打印申请书界面
@property (nonatomic,assign)BOOL isApplyTop;//是否是查看申请书界面
@property (nonatomic,assign)BOOL isContractTop;//是否是查看合同界面
@property (nonatomic,assign)BOOL isDaFenQiApply;//是否是达分期申请界面
@end

@interface MainCommandDelegate : CDVCommandDelegateImpl
@end

@interface MainCommandQueue : CDVCommandQueue
@end
