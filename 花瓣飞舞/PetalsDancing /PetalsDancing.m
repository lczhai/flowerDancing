//
//  PetalsDancing.m
//  花瓣飞舞
//
//  Created by shining3d on 16/8/8.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import "PetalsDancing.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@implementation PetalsDancing

- (id)initWithFrame:(CGRect)frame movePath:(CGPathRef)path
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		
		[self animationEmitter];
		
		if (!path) {
			path = [self defaultPath];
		}
		[self animationMoveWithPath:path];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		[self animationEmitter];
		
		[self animationMoveWithPath:[self defaultPath]];
	}
	return self;
}

- (void)animationEmitter
{
	CAEmitterLayer *emitterLayer = (CAEmitterLayer *)self.layer;
	emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//发射位置
	emitterLayer.emitterSize = self.bounds.size; //发射源的大小
	emitterLayer.renderMode = kCAEmitterLayerAdditive;//	渲染模式
	emitterLayer.emitterMode = kCAEmitterLayerPoints; //发射模式
	emitterLayer.emitterShape = kCAEmitterLayerSphere;//发射源的形状
	
 
	UIImage *image = [UIImage imageNamed:@"rose.jpg"];
	CAEmitterCell *cell1 = [self createEmitterCellWithContents:(id)[image CGImage]];
	cell1.scale = 0.3;//图片缩放比例
	cell1.scaleRange = 0.1;//缩放范围
	
	emitterLayer.emitterCells = @[cell1];
}

- (CAEmitterCell *)createEmitterCellWithContents:(id)contents
{
	CAEmitterCell *cell = [CAEmitterCell emitterCell];
	cell.birthRate = 120;//出生率    (动画每秒钟散射出来的对象数量)
	cell.lifetime = 3;   //每一个散射出来的对象的实名周期（声明时长）
	cell.lifetimeRange = 0.3;//生命周期范围 lifetime= lifetime(+/-) lifetimeRange  (lifetime-lifetimeRangelifetime<lifetime+lifetimeRange)
	
	cell.contents = contents;
	cell.color = [[UIColor whiteColor] CGColor];//散射出的对象的主色调
	cell.velocity = 50;  //散射对象的速度
	cell.velocityRange = 10;//散射对象速度的范围
	cell.emissionLongitude = M_PI*2;//x-y平面的发射方向
	cell.emissionRange = M_PI*2;//发射方向的范围
	
	cell.spin = 0;//对象旋转角度(角度越大速度就需要越快，所以页可理解为速度1-90)
	
	   
	return cell;
}


- (void)animationMoveWithPath:(CGPathRef)path
{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"emitterPosition"];
	animation.path = path;
	animation.duration = 5; //设置动画完成的时间
	animation.repeatCount = MAXFLOAT;
	[self.layer addAnimation:animation forKey:nil];
}

- (CGPathRef)defaultPath
{
	CGMutablePathRef path = CGPathCreateMutable();
	//后两个参数为动画开始的点
	CGPathMoveToPoint(path, NULL, SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.1);
	
	//绘制曲线（？，？，曲线途径点1的x，曲线途径的点1y，曲线途径点2的x，曲线途径的点2y，曲线的终点x，曲线终点y）
	CGPathAddCurveToPoint(path, NULL, SCREEN_WIDTH*0.3 , SCREEN_HEIGHT*0.3, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.9);
	
	return path;
}


+ (Class)layerClass
{
	return [CAEmitterLayer class];
}


@end
