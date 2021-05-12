//
// Created by uu on 2021/5/11.
//

#import <Foundation/Foundation.h>


@interface YTKRequestionManager : NSObject


+ (YTKRequestionManager *)manager;

/**
 key : apiCode + 参数列表字符串
 value : time
 */
@property(nonatomic, strong, readonly) NSMutableDictionary *requestingPool;//请求池

@property(nonatomic, strong) NSLock *requestionLock;//请求锁

@property(nonatomic, strong) NSMutableArray *requestionTasks;//请求任务，用于频繁请求时取消请求

- (void)lock;

- (void)unlock;

/**
 增加一个请求

 @param keyUrl 请求  apiCode + 参数列表字符串
 @return 是否成功增加 如果失败则说明为重复的请求
 */
- (BOOL)addRequestionWithKeyUrl:(NSString *)keyUrl;


/**
 删除请求

 @param keyUrl 请求 apiCode + 参数列表字符串
 @return 是否成功 如果失败则说明 此请求不存在
 */
- (BOOL)removeRequestionWithKeyUrl:(NSString *)keyUrl;


/**
 获取该请求的开始时间

 @param keyUrl 请求 apiCode + 参数列表字符串
 @return 返回请求该的开始请求的时间 0即为无该请求
 */
- (NSTimeInterval)timeWithRequestionKeyUrl:(NSString *)keyUrl;
/**
 当前时间
 */
- (NSTimeInterval)nowTime;
/**
 添加请求任务
 @param dataTask 请求任务
 */
- (BOOL)addRequestionTask:(NSURLSessionDataTask *)dataTask;

- (BOOL)removeRequestionTasks;
@end