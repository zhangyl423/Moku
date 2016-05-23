//
//  GlobalConfig.h
//  MoKu
//
//  Created by Zhang on 16/5/8.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h

#define APPID                             1060019235
#define TUSDK_APPKEY                      @"2b8b0ed8c473311b-02-b20do1"

#define SCREENWIDTH                       ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT                      ([UIScreen mainScreen].bounds.size.height)
#define TABBARHEIGHT                      (49)
#define NAVIGATIONHEIGHT                  (64)
#define HEIGHT(o)                         (o.frame.size.height)
#define WIDTH(o)                          (o.frame.size.width)
#define X(o)                              (o.frame.origin.x)
#define Y(o)                              (o.frame.origin.y)
#define BOTTOM(o)                         (o.frame.origin.y + o.frame.size.height)
#define RIGHT(o)                          (o.frame.origin.x + o.frame.size.width)

#define PUSH(v)                           [self.navigationController pushViewController:v animated:YES]
#define SHOW(v)                           [self presentViewController:v animated:YES completion:nil]
#define POP                               [self.navigationController popViewControllerAnimated:YES]
#define DIMISS                            [self dismissViewControllerAnimated:YES completion:nil]

#define FONT(s)                           [UIFont systemFontOfSize:s]
#define BOLDFONT(s)                       [UIFont boldSystemFontOfSize:s]

#define SET_NSUSERDEFAULT(k, o)           ([[NSUserDefaults standardUserDefaults] setObject:o forKey:k])
#define GET_NSUSERDEFAULT(k)              ([[NSUserDefaults standardUserDefaults] objectForKey:k])
#define SHORT_APPVERSION                  ([NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"])

#endif /* GlobalConfig_h */
