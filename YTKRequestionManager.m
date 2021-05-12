//
// Created by uu on 2021/5/11.
//

#import "YTKRequestionManager.h"


@implementation YTKRequestionManager
@synthesize requestingPool;

+ (YTKRequestionManager *)manager {
    static YTKRequestionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSLock *)requestionLock {
    if (!_requestionLock) {
        _requestionLock = [[NSLock alloc] init];
    }
    return _requestionLock;
}

- (NSMutableDictionary *)requestingPool {
    if (!requestingPool) {
        requestingPool = [NSMutableDictionary dictionary];
    }
    return requestingPool;
}


- (NSTimeInterval)nowTime {
    return [[NSDate date] timeIntervalSince1970];
}

- (void)lock {
    [self.requestionLock lock];
}

- (void)unlock {
    [self.requestionLock unlock];
}

- (BOOL)addRequestionWithKeyUrl:(NSString *)keyUrl {
    if (![self isExistWithKeyUrl:keyUrl]) {
        self.requestingPool[keyUrl] = @(self.nowTime);
        return YES;
    }
    return NO;
}

- (BOOL)removeRequestionWithKeyUrl:(NSString *)keyUrl {
    if ([self isExistWithKeyUrl:keyUrl]) {
        [self.requestingPool removeObjectForKey:keyUrl];
        return YES;
    }
    return NO;
}

- (NSTimeInterval)timeWithRequestionKeyUrl:(NSString *)keyUrl {
    if ([self isExistWithKeyUrl:keyUrl]) {
        NSNumber *time = self.requestingPool[keyUrl];
        return time.doubleValue;
    }
    return 0;
}

- (BOOL)isExistWithKeyUrl:(NSString *)keyUrl {
    for (NSString *key in self.requestingPool.allKeys) {
        if ([key isEqualToString:keyUrl]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)addRequestionTask:(NSURLSessionDataTask *)dataTask {
    if (!self.requestionTasks) {
        self.requestionTasks = [NSMutableArray array];
    }

    [self removeRequestionTasks];
    [self.requestionTasks addObject:dataTask];

    return NO;
}

- (BOOL)removeRequestionTasks {
    [self.requestionTasks enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        NSURLSessionDataTask *dataTask = (NSURLSessionDataTask *) obj;
        [dataTask cancel];
        [_requestionTasks removeObject:obj];
    }];
    return NO;
}

@end