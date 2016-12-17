//
//  ViewController.m
//  KVC
//
//  Created by 隆大佶 on 2016/12/15.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "UIImage+PureColorImage.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([object isEqual:self.tableView] && [keyPath isEqualToString:@"contentOffset"])
    {
        [self refreshNavigationBar];
    }

 }

- (void)refreshNavigationBar
{
    CGPoint offset = self.tableView.contentOffset;
    
    /* 当 offset.y 值小于0时,状态栏隐藏, 其余时候显示 */
    self.navigationController.navigationBarHidden = (offset.y <= 0);
    
    /* 在这个页面中, 我的轮播图的宽高比是180:300 */
    /* 那么我先算出轮播图的高度 */
    CGFloat cycleScrollViewHeight = kScreenWidth * 180 / 300;
    
    /* 用 offset 值比上轮播图的高度,那么,当轮播滚动范围的 y 值等于轮播图的高度时, navigationBar 就完全不透明了 */
    CGFloat alpha = MIN(1, fabs(offset.y / cycleScrollViewHeight));
    
    /* 设置 透明度为 NO 来消除 alpha 为1时的系统化透明 */
    
    BOOL translucent = !(int)alpha; /* 也就是说,当tableView 越往下拖, alpha 值为1,navigationBar 的透明度就始终保持不透明 */
    [self.navigationController.navigationBar setTranslucent:translucent];
    
    /* 设置实时的颜色 */
    UIColor *realTimeColor = [UIColor colorWithRed:0.14 green:0.79 blue:0.67 alpha:alpha];
    /* 用实时的颜色生成一张纯色的图片 */
    UIImage *image = [self navigationBarImageWithColor:realTimeColor];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    /* 消除阴影 */
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (UIImage *)navigationBarImageWithColor:(UIColor *)color
{
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    CGSize statusBarSize = [[UIApplication sharedApplication]statusBarFrame].size;
    
    return [UIImage yf_imageWithPureColor:color size:CGSizeMake(navigationBarSize.width, navigationBarSize.height + statusBarSize.height)];
}
@end
