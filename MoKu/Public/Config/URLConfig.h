//
//  URLConfig.h
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#ifndef URLConfig_h
#define URLConfig_h

#define BASE_URL                        (DEBUG ? @"http://dev.moku.net/" : @"http://server.moku.net/")

#define STATISTICAL_URL                 @"http://120.26.98.218"
#define APPSTORE_URL                    [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@lu", APPID]

#endif /* URLConfig_h */
