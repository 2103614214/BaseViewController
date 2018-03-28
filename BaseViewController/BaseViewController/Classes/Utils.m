//
//  Utils.m
//  BaseViewController
//
//  Created by 汪亮 on 2018/3/28.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import "Utils.h"
#import "AFNetworking.h"

@implementation Utils

// GET
+ (void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure{
    
    
    // 初始化管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/json",@"text/javascript",@"xml/json", nil];
    manager.requestSerializer.timeoutInterval = 60;
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




// POST
+ (void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^) (NSError *))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json",@"text/json",@"text/javascript",@"json/xml", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
    
    [manager.requestSerializer  setValue:@"application/json"  forHTTPHeaderField:@"Content－Type"];
    
    manager.requestSerializer.timeoutInterval = 60.f;
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success ) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
