//
//  MKApiManager.h
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MKApiManager : AFHTTPRequestOperationManager

+ (instancetype)shareApiManager;
//检查网络环境
+ (void)checkReachability:(void (^)(NSString * type))successResult Failure:(void (^)(void))failureResult;

@end
