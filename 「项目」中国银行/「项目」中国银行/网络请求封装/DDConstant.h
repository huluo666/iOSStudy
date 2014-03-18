//
//  DDConstant.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#ifndef _________DDConstant_h
#define _________DDConstant_h

#define kBaseRoot @"http://192.168.10.201:8080/rimicms/resources/"
// JSON数据类型
#define kJSONParamKey @"paramJson"
#define kContentKey @"content"
#define kResultCodeKey @"resultCode"

// 登录
#define kLogin @"appIndex/appLogin"
#define kUsernameKey @"username"
#define kPasswordKey @"password"

// 首页最近产品列表
#define kRecentProductsList @"appIndex/getRecentProductsList"
#define kTotalNumberKey @"totalNum"
// 首页最新消息列表
#define kRecentNewsList @"appIndex/getRecentNewsList"
#define kPageNumKey @"pageNum"
#define kPageSizeKey @"pageSize"
// 首页热点消息
#define kHotProductList @"appIndex/getHotProductList"
#define kUserIDKey @"userId"
#define kTotalNumberKey @"totalNum"
// 产品定制
#define kCustomizationList @"appIndex/getCustomizationList"

// 出国服务
#define kPolicyAdviceList @"appAbroad/getPolicyAdviceList"
#define kByTitleKey @"byTitle"
#define kByKeywordsKey @"byKeywords"

// 自选模式
#define kOptionalList @"appAbroad/getChooseByYourselfModeList"
#define kTypeIdKey @"typeId"

// 理财产品
#define kFundList @"appFinancial/getFundList"

// 贵金属
#define kMetalsList @"appFinancial/getMetalsList"
#define kSupplierIdKey @"supplierId"
#define kPurposeIdKey @"purposeId"
#define kAgeIdKey @"ageId"

// 保险
#define kInsureList @"appFinancial/getInsureList"

#endif
