//
//  TestViewController.m
//  BaseViewController
//
//  Created by 汪亮 on 2018/3/28.
//  Copyright © 2018年 汪亮. All rights reserved.
//

#import "TestViewController.h"
#import "MJRefresh.h"

@interface TestViewController () <UITableViewDelegate,UITableViewDataSource>

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

//当前请求页码
@property (nonatomic, assign)NSInteger pageIndex;

@end


static NSString * const testId = @"testId";
@implementation TestViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试";
    
    // 初始页码
    self.pageIndex = 1;
    
    //  添加  下拉/上拉
    __weak typeof(self) WeakSelf = self;
    [self createMJRefresh:isAllRefresh actionBlock:^{
        [WeakSelf MJRequestData];
    }];
  
    
    //  网络请求
    [self MJRequestData];
    
    
    //  添加 主tableView
    self.mainTableView.rowHeight = 60;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    // 注册 重用名
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:testId];
    [self.view addSubview: self.mainTableView];
    
}

-(void)dealloc{
    NSLog(@"------dealloc");
}

// 网络请求数据
- (void)MJRequestData{
    if (self.judge == 10) {
        // 下拉时 清空数据数组 重新请求添加
        self.pageIndex = 1;
        [self.dataArray removeAllObjects];
    } else if (self.judge == 11){
        // 上拉时  数组中添加内容
        self.pageIndex++;
    }
    __weak typeof(self) WeakSelf = self;
    
    //转换一下
    NSString *Number = [NSString stringWithFormat:@"%ld",(long)self.pageIndex];
    
    NSDictionary *parameters = @{@"pageNum": Number, @"pageSize":@"10",@"content" : @""};
    
    //网络请求
    NSString *urlString = @"http://app.51zzj.com.cn/api/expert/list/init.htm";
   
    [super PostRequsetDataUrlString:urlString Parameters:parameters];
    self.PostSuccess=^(id responseObject){
        //解析
        NSArray *rootArray = responseObject[@"businessData"];
        
        for (NSDictionary *smallDict in rootArray) {
            
            //NSLog(@"%@",smallDict);
            //处理数据，转模型之类的
            [WeakSelf.dataArray addObject:@"1"];

        }
        
        //刷新数据
        [WeakSelf.mainTableView reloadData];
        
        [WeakSelf.mainTableView.mj_header endRefreshing];
        
        if (rootArray.count == 0) {
            // 为零时 实现没有更多数据
            [WeakSelf.mainTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [WeakSelf.mainTableView.mj_footer endRefreshing];
        }
    };
}



//  数组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark ------- 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testId];
    
    // 重用
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld列----第%ld行",indexPath.section,indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
