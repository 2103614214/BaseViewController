//
//  Utils.h
//  BaseViewController
//
//  Created by 汪亮 on 2018/3/28.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

// GET
+ (void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

// POST
+ (void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^) (NSError *))failure;

@end
