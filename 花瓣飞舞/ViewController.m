//
//  ViewController.m
//  花瓣飞舞
//
//  Created by shining3d on 16/8/8.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import "ViewController.h"
#import "PetalsDancing.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	PetalsDancing *flower = [[PetalsDancing alloc]initWithFrame:self.view.bounds];
	[self.view addSubview:flower];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
