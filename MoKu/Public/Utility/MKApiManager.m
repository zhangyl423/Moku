//
//  MKApiManager.m
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKApiManager.h"

@implementation MKApiManager

+ (instancetype)shareApiManager {
    static MKApiManager * apiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[MKApiManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        AFJSONResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [responseSerializer setRemovesKeysWithNullValues:YES];
        [apiManager setResponseSerializer:responseSerializer];
    });
    
    return apiManager;
}

#pragma mark - 检查网络环境
+ (void)checkReachability:(void (^)(NSString * type))successResult Failure:(void (^)(void))failureResult {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (successResult) {
                    successResult(@"WWAN");
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (successResult) {
                    successResult(@"WIFI");
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                if (failureResult) {
                    failureResult();
                }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 登录

@end
