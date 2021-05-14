//
// Created by uu on 2021/5/14.
//

#import <Foundation/Foundation.h>


@interface YTKDNSAnalysisManger : NSObject


/// PreResolveHosts
@property(nonatomic, strong) NSArray <NSString *> *preResolveHosts;

/**
 获取httpDns管理单例

 @return 单例
 */
+ (YTKDNSAnalysisManger *)analysisManger;

/**
 配置单例

 @param accountID HTTPDNS Account ID
 @param secretKey 鉴权对应的 secretKey
 */
- (void)configWithAccountID:(int)accountID andSecretKey:(NSString *)secretKey;


/**
 获取对应域名的解析结果（异步）

 @param host 域名
 @return 解析结果
 */
- (NSString *)getIpByHostAsyncInURLFormat:(NSString *)host;


/**
 结合指定host解析并替换。

 @param orangeUrl 原urlString
 @param hostName 域名
 @return 解析后的urlString
 */
- (NSString *)replaceDomainNameOrangeUrl:(NSString *)orangeUrl andHostName:(NSString *)hostName;


/**
 根据指定的原url直接解析替换

 @param orangeUrl 原urlString
 @return 解析后的urlString
 */
- (NSString *)replaceDomainNameOrangeUrl:(NSString *)orangeUrl;

@end