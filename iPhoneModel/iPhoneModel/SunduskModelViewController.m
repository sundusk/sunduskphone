//
//  SunduskModelViewController.m
//  iPhoneModel
//
//  Created by sundusk on 2018/3/6.
//  Copyright © 2018年 sundusk. All rights reserved.
//

#import "SunduskModelViewController.h"

#import <Masonry.h>
#import "CCQiPhoneXQViewController.h"
@interface SunduskModelViewController ()
@property (nonatomic, weak)UIView *iPhoneInforView;
@end

@implementation SunduskModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    UIView *iPhoneInforView = [[UIView alloc]init];
    iPhoneInforView.backgroundColor = [UIColor redColor];
    self.iPhoneInforView = iPhoneInforView;
    [self.view addSubview:iPhoneInforView];
    
    [self setUp];
    

}
// 布局
- (void)setUp{
    NSLog(@"布局成功");
    
    [_iPhoneInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
         // make.width.equalTo(@100);
        //  make.height.mas_equalTo(100);
        //        make.centerX.equalTo(self.view);
        //        make.centerY.equalTo(self.view);
        
        //约束的代码
//
//        //设置View的顶部距离父控件的顶部20
//        //        make.top.equalTo(self.view.mas_top).offset(20);
//        make.top.equalTo(self.view).offset(20);
//
//        //如果设置约束的控件的属性和参照的控件的属性一致，被参照的控件的属性可以省略不写
//        make.left.equalTo(self.view).offset(20);
//
//        make.bottom.equalTo(self.view).offset(-20);
//
//        make.right.equalTo(self.view).offset(-20);
    }];
   
    
    UIButton *iPhoneButton = [[UIButton alloc]init];
    
    
    iPhoneButton.backgroundColor = [UIColor yellowColor];
    [iPhoneButton addTarget:self action:@selector(BthClick:) forControlEvents:UIControlEventTouchUpInside];
    [_iPhoneInforView addSubview:iPhoneButton];
    [iPhoneButton setTitle:@"手机详情" forState:UIControlStateNormal];
    [iPhoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    iPhoneButton.titleLabel.font = [UIFont systemFontOfSize:10];
   
    [iPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iPhoneInforView).offset(20);
        make.right.equalTo(_iPhoneInforView).offset(-20);
        make.top.equalTo(_iPhoneInforView).offset(20);
        make.bottom.equalTo(_iPhoneInforView).offset(-20);
    }];
    
    
}
- (void)BthClick:(UIButton *)btn{
    NSLog(@"点击跳转到此页面");
    
    CCQiPhoneXQViewController *vc2=[[CCQiPhoneXQViewController alloc] init];
    [self presentModalViewController:vc2 animated:YES];
    
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
