//
//  YTKCookieUtility.h
//  YTKNetwork
//
//  Created by uu on 2021/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTKCookieUtility : NSObject

+ (NSString *)nCookiesStringForUrl:(NSString *)urlString;

+ (void)nRemoveAllCookies;

@end

NS_ASSUME_NONNULL_END
