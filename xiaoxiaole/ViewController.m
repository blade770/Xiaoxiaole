//
//  ViewController.m
//  xiaoxiaole
//
//  Created by blade770 on 16/4/24.
//  Copyright © 2016年 blade770. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)StartGame
{
    NSMutableArray* arrStr = [[NSMutableArray alloc]init];
    
    for (int k=0; k<18; k++)
    {
        int random = arc4random()%12 + 1;
        NSString* strName = [NSString stringWithFormat:@"%d",random];
        //添加到数组中
        [arrStr addObject:strName];
        [arrStr addObject:strName];
    }
    
    //循环创建36个按钮
    for (int i=0; i<6; i++)
    {
        for (int j=0; j<6; j++)
        {
            //创建自定义按钮
            UIButton* btn= [UIButton buttonWithType: UIButtonTypeCustom];
            
            //添加开场动画
            btn.frame = CGRectMake(160, 160, 50, 50);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            
            //按钮布局
            btn.frame = CGRectMake(10+50*j, 40+50*i, 50, 50);
            [UIView commitAnimations];
            //产生随即图片
            int indexRandom = arc4random()%arrStr.count;
            //从图像数组中取出文件名，成对的
            NSString* strIcon = arrStr[indexRandom];
            NSInteger tag = [strIcon integerValue];
            [arrStr removeObjectAtIndex:indexRandom];
            
            UIImage* icon = [UIImage imageNamed:strIcon];
            [btn setImage:icon forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
            //将按钮的标志位赋值
            btn.tag = tag;
        }
    }
}

-(void)pressBtn:(UIButton*) btn
{
    NSLog(@"按钮被按下");
    
    //创建一个静态变量，保存第一次按下的按钮
    static UIButton* btnFirst = nil;
    
    if (btnFirst == nil)
    {
        btnFirst = btn;
        //锁定一个按钮
        btnFirst.enabled = NO;
    }
    else
    {
        //两个按钮图像相同
        if (btnFirst.tag == btn.tag)
        {
            btnFirst.hidden = YES;
            btn.hidden = YES;
            btnFirst = nil;
        }
        //两个按钮图像不相同
        else
        {
            btnFirst.enabled = YES;
            btnFirst = nil;
        }
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self StartGame];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
