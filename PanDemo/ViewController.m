//
//  ViewController.m
//  PanDemo
//
//  Created by qianzhan on 15/11/23.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "ViewController.h"
#import "YKButton.h"

@interface ViewController ()

{
    CGPoint _oldPoint;
    
    CGPoint _centerPoint;
    UIImageView *imageView;
    
    
}

@property (strong, nonatomic) CALayer *colorLayer;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    imageView.center =self.view.center;
    imageView.image = [UIImage imageNamed:@"index.jpg"];
    imageView.layer.masksToBounds  = YES;
    imageView.layer.cornerRadius = 75;
    [self.view addSubview:imageView];

    _centerPoint = self.view.center;
    _oldPoint = CGPointMake(0, 0);
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [imageView addGestureRecognizer:rotationGestureRecognizer];
    
//    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
//    [bezierPath moveToPoint:CGPointMake(0, 150)];
//    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
//    //draw the path using a CAShapeLayer
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.path = bezierPath.CGPath;
//    pathLayer.fillColor = [UIColor clearColor].CGColor;
//    pathLayer.strokeColor = [UIColor redColor].CGColor;
//    pathLayer.lineWidth = 3.0f;
//    [self.view.layer addSublayer:pathLayer];
//    //add the ship
//    CALayer *shipLayer = [CALayer layer];
//    shipLayer.frame = CGRectMake(0, 0, 64, 64);
//    shipLayer.position = CGPointMake(0, 150);
//    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"main.png"].CGImage;
//    [self.view.layer addSublayer:shipLayer];
//    //create the keyframe animation
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 4.0;
//    animation.path = bezierPath.CGPath;
//    animation.rotationMode = kCAAnimationRotateAuto;
//    [shipLayer addAnimation:animation forKey:nil];

}



// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    _oldPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint newPoint = [touch locationInView:self.view];
    
    CGFloat angle = [self returnTransformAngle:newPoint];
    
    if ((newPoint.x <= _oldPoint.x && _oldPoint.y <= _centerPoint.y) || (newPoint.x >= _oldPoint.x && _oldPoint.y >= _centerPoint.y)) {
        angle = - angle;
    }
    
   // NSLog(@"angle = %f", angle);
    
    imageView.transform = CGAffineTransformRotate(imageView.transform, angle);
    
    
    _oldPoint = newPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   _oldPoint = CGPointMake(-1, -1);
}

#pragma mark -------------------function

//get the angle
- (CGFloat)returnTransformAngle:(CGPoint)newPoint{

    CGFloat a = [self returnLengthFrom:_centerPoint to:_oldPoint];
    CGFloat b = [self returnLengthFrom:_centerPoint to:newPoint];
    CGFloat c = [self returnLengthFrom:_oldPoint to:newPoint];
    
    return acos((a*a+b*b-c*c)/(2*a*b));
}

//return the dsitance form one point to other point
- (CGFloat)returnLengthFrom:(CGPoint)originPoint to:(CGPoint)endPoint{
    CGFloat a = fabs(originPoint.x-endPoint.x);
    CGFloat b = fabs(originPoint.y-endPoint.y);
    return  sqrtf(a*a+b*b);
}

//verify a point is located in the circle
- (BOOL)touchPointInCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point{
    CGFloat distance = sqrtf((point.x-center.x)*(point.x-center.x) + (point.y-center.y)*(point.y-center.y));
    return (distance<=radius);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
