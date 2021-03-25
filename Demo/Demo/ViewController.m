//
//  ViewController.m
//  Demo
//
//  Created by 张慧鑫 on 2021/3/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"标题1";
    self.navigationItem.title = @"标题2";
    UILabel *customTitleVIew = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    customTitleVIew.text = @"标题3";
    customTitleVIew.font = [UIFont systemFontOfSize:18];
    customTitleVIew.textColor = [UIColor blackColor];
    //设置位置在中心
    customTitleVIew.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = customTitleVIew;
}


@end
