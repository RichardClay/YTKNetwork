//
//  YTKCookieUtility.m
//  YTKNetwork
//
//  Created by uu on 2021/5/26.
//

#import "YTKCookieUtility.h"

@implementation YTKCookieUtility

+ (NSString *)nCookiesStringForUrl:(NSString *)urlString {
    NSArray<NSHTTPCookie *> *array = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *host = url.host;
    NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
    for (NSHTTPCookie *cookie in array) {
        if ([self domain:cookie.domain isSameHost:host]) {
            cookies[cookie.name] = cookie.value;
        }
    }
    
    return [self getStringWithDictionary:cookies];
}

+ (NSString *)getStringWithDictionary:(NSDictionary *)dic {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dic allKeys].count; i++) {
        NSString *currentStr = [NSString stringWithFormat:@"%@=%@", [[dic allKeys] objectAtIndex:i], [dic valueForKey:[[dic allKeys] objectAtIndex:i]]];
        [array addObject:currentStr];
    }
    NSString *string = @"";
    for (int i = 0; i < array.count; i++) {
        if (i > 0) {
            string = [NSString stringWithFormat:@"%@;%@", string, [array objectAtIndex:i]];
        } else {
            string = [array objectAtIndex:i];
        }
    }
    return string;
}


+ (BOOL)domain:(NSString *)domain isSameHost:(NSString *)host {
    NSArray *domains = [YTKCookieUtility nReverseObjects:[domain componentsSeparatedByString:@"."]];
    NSArray *hosts   = [YTKCookieUtility nReverseObjects:[host componentsSeparatedByString:@"."]];
    NSInteger min = MIN(domains.count, hosts.count);
    NSInteger sameCount = 0;
    for (NSInteger i = 0; i < min; ++i) {
        if ([domains[i] isEqualToString:hosts[i]]) {
            sameCount++;
        } else {
            break;
        }
    }
    return sameCount > 1;
}

+ (void)nRemoveAllCookies {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] removeCookiesSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

+ (NSArray *)nReverseObjects:(NSArray *)content {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:content.count];
    [mutableArray addObjectsFromArray:[[content reverseObjectEnumerator] allObjects]];
    return mutableArray;
}



@end
