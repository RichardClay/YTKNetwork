//
// Created by uu on 2021/5/14.
//

#import <AlicloudHttpDNS/AlicloudHttpDNS.h>
#import "YTKDNSAnalysisManger.h"

@interface YTKDNSAnalysisManger () <HttpDNSDegradationDelegate>

@property(nonatomic, strong) HttpDnsService *dansManger;

@end

@implementation YTKDNSAnalysisManger

+ (YTKDNSAnalysisManger *)analysisManger {
    static YTKDNSAnalysisManger *dnsManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dnsManger = [[YTKDNSAnalysisManger alloc] init];
    });
    return dnsManger;
}

- (HttpDnsService *)dansManger {
    if (!_dansManger) {
        _dansManger = [HttpDnsService sharedInstance];
    }
    return _dansManger;
}

- (void)configWithAccountID:(int)accountID andSecretKey:(NSString *)secretKey {
    HttpDnsService *httpDns = [[HttpDnsService alloc] initWithAccountID:accountID secretKey:secretKey];
    [httpDns setLogEnabled:YES];
    [httpDns setAuthCurrentTime:[[NSDate date] timeIntervalSince1970]];
    [self.dansManger setHTTPSRequestEnabled:YES];
    [self.dansManger setPreResolveHosts:self.preResolveHosts];
    [self.dansManger setLogEnabled:YES];
    [self.dansManger setPreResolveAfterNetworkChanged:YES];
    [self.dansManger setExpiredIPEnabled:YES];
    [self.dansManger setCachedIPEnabled:YES];
}


- (NSString *)getIpByHostAsyncInURLFormat:(NSString *)host {
    return [self.dansManger getIpByHostAsyncInURLFormat:host];
}

- (void)setDegradationFilter {
    [self.dansManger setDelegateForDegradationFilter:self];
}

/**
 域名降级的代理实现

 @param hostName 域名
 @return 是否降级
 */

- (BOOL)shouldDegradeHTTPDNS:(NSString *)hostName {
    return false;
}

- (NSString *)replaceDomainNameOrangeUrl:(NSString *)orangeUrl andHostName:(NSString *)hostName {
    NSString *dnsAna = [self.dansManger getIpByHostAsyncInURLFormat:hostName];
    if (dnsAna) {
        return [orangeUrl stringByReplacingOccurrencesOfString:hostName withString:dnsAna];
    } else {
        return orangeUrl;
    }
}

- (NSString *)replaceDomainNameOrangeUrl:(NSString *)orangeUrl {
    NSURL *url = [NSURL URLWithString:orangeUrl];
    NSString *ip = [self.dansManger getIpByHostAsyncInURLFormat:url.host];
    if (ip) {
        return [orangeUrl stringByReplacingOccurrencesOfString:url.host withString:ip];
    } else {
        return orangeUrl;
    }
}


@end