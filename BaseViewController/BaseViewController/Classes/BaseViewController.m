//
//  BaseViewController.m
//  BaseViewController
//
//  Created by 汪亮 on 2018/3/28.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"
#import "Utils.h"
// 屏幕宽
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
// 屏幕高
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
//导航栏高度
#define kNavBarHeight 44.0
//顶部NavBar高度   状态栏+ 导航栏
#define kNavBarStatusHeight ([[UIApplication sharedApplication] statusBarFrame].size.height+ kNavBarHeight)

@interface BaseViewController ()


@end


@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景色
    self.view.backgroundColor = [UIColor whiteColor];

    //  从导航栏 计算 位置
    self.edgesForExtendedLayout = UIRectEdgeNone;

    // 导航栏 颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //  导航栏 按钮  颜色
    self.navigationController.navigationBar.tintColor  = [UIColor whiteColor];

    //返回按钮
    [self AddNavigationRetunItem];
}





//  get 请求数据
- (void)GetRequsetDataUrlString:(NSString *)url Parameters:(NSDictionary *)dic{
    
     __weak typeof(self) WeakSelf = self;

    [Utils GET:url parameters:dic success:^(id  responseObject) {
        
        
        WeakSelf.GetSuccess(responseObject);
   
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}



// post 请求数据
- (void)PostRequsetDataUrlString:(NSString *)url Parameters:(NSDictionary *)dic{
    
    __weak typeof(self) WeakSelf = self;
    [Utils POST:url  parameters:dic success:^(id responseObject) {
    
         WeakSelf.PostSuccess(responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}



//  创建  MJ刷新
- (void)createMJRefresh:(RefreshType)type actionBlock:(refreshBlock)actionBlock{
    
    __weak typeof (self)weakSelf = self;
    //下拉  刷新
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //开始刷新数据
        [weakSelf.mainTableView.mj_header beginRefreshing];
        
        weakSelf.judge = 10;
        weakSelf.actionBlock = actionBlock;
        weakSelf.actionBlock();

    }];
    
    if (type == isAllRefresh) {
        //上拉   加载
        self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //开始刷新数据
            [weakSelf.mainTableView.mj_footer beginRefreshing];
            
            weakSelf.judge = 11;
            weakSelf.actionBlock = actionBlock;
            weakSelf.actionBlock();
           
        }];
    }
    
    
    
   

}




#pragma mark ====  添加返回按钮
- (void)AddNavigationRetunItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login_btn_back_22_22"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  -----   懒加载
- (UITableView *)mainTableView{
    if (_mainTableView == nil){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT-kNavBarStatusHeight)];
        //隐藏cell线
        _mainTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        // 隐藏滑动条
        _mainTableView.showsVerticalScrollIndicator = NO;
        // tableView多余cell空白
        _mainTableView.tableFooterView = [[UIView alloc]init];
      
    }
    return _mainTableView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
