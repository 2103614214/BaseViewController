//
//  BaseViewController.h
//  BaseViewController
//
//  Created by 汪亮 on 2018/3/28.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(int, RefreshType) {
    isAllRefresh,
    isDownRfresh,
};

typedef void (^refreshBlock)(void);
@interface BaseViewController : UIViewController


// 创建  上拉 下拉 刷新
- (void)createMJRefresh:(RefreshType)type actionBlock:(refreshBlock)actionBlock;

/** 刷新block */
@property(nonatomic,copy) refreshBlock actionBlock;

// 判断上拉/下拉   下拉->10  上拉->11
@property (nonatomic, assign)NSInteger judge;


//在这里面写入网络请求成功后的数据解析以及其它代码
@property(nonatomic,copy)void(^GetSuccess)(id GetData);
//  post返回
@property(nonatomic,copy)void(^PostSuccess)(id PostData);
//  get 请求数据
- (void)GetRequsetDataUrlString:(NSString *)url Parameters:(NSDictionary *)dic;
//  post 请求数据
- (void)PostRequsetDataUrlString:(NSString *)url Parameters:(NSDictionary *)dic;

// TableView
@property (nonatomic, strong)UITableView *mainTableView;

//返回 ,方便子页面重写
-(void)back;


@end
