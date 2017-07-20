//
//  MLGradientLoadingIndicator.m
//  MLGradientLoadingIndicatorDemo
//
//  Created by MogLu on 20/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "MLGradientLoadingIndicator.h"

@implementation MLGradientLoadingIndicator
{
@private CAMediaTimingFunction *_timeFunc;
@private CAGradientLayer *_backgroundLayer;
@private CAShapeLayer *_shadeLayer;
@private CGFloat _radius;
}

-(instancetype)initWithRaduis:(CGFloat) radius setAnnulusWidth:(CGFloat) width setGradientColors:(NSArray*) colors;
{
    if(self = [super init])
    {
        _annulusWidth = width;
        _gradientColors = colors;
        _isAnimating = NO;
        _radius = radius;
        self.frame = CGRectMake(0, 0, _radius*2, _radius*2);
        self.backgroundColor = UIColor.clearColor;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)showInViewcenter:(UIView*) superview
{
    [superview addSubview:self];
    self.center = superview.center;
    [self setShade];
    [self starAnimation];
}

-(void)starAnimation
{
    if(!_isAnimating)
    {
        [self renderAnimation];
        _isAnimating = YES;
    }
}

-(void)stopAnimation
{
    _isAnimating = NO;
    [self.layer removeAllAnimations];
}

-(void)layoutSubviews
{
    }

-(void)setShade
{
    _shadeLayer = [[CAShapeLayer alloc] init];
    _shadeLayer.frame = self.bounds;
    _shadeLayer.lineWidth = _annulusWidth;
    _shadeLayer.fillColor = UIColor.clearColor.CGColor;
    _shadeLayer.strokeColor = UIColor.blackColor.CGColor;
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat raduis = (self.frame.size.height - _annulusWidth)/2;
    CGFloat startAngle = 0;
    CGFloat endAngle = M_PI * 2;
    
    UIBezierPath *shadeLayerPath = [UIBezierPath bezierPathWithArcCenter:center radius:raduis startAngle:startAngle endAngle:endAngle clockwise:YES];
    _shadeLayer.path = shadeLayerPath.CGPath;
    _shadeLayer.strokeStart = 0;
    _shadeLayer.strokeEnd = 0;
    
    _backgroundLayer = [[CAGradientLayer alloc]init];
    _backgroundLayer.frame = self.bounds;
    _backgroundLayer.colors = _gradientColors;
    _backgroundLayer.startPoint = CGPointMake(0, 0);
    _backgroundLayer.endPoint = CGPointMake(1,1);
    [_backgroundLayer setMask:_shadeLayer];
    [self.layer addSublayer:_backgroundLayer];

}

-(void)renderAnimation
{
    if(!_isAnimating)
    {
        CGFloat pathAnimationTime = 1.5;
        CGFloat firstPartTime = pathAnimationTime * 0.55f;
        CGFloat secondPartTime = pathAnimationTime - firstPartTime;
        
        CABasicAnimation *globalRotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        globalRotate.duration = 4;
        globalRotate.repeatCount = CGFLOAT_MAX;
        globalRotate.removedOnCompletion = false;
        globalRotate.fromValue = [NSNumber numberWithDouble:0];
        globalRotate.toValue = [NSNumber numberWithDouble:M_PI * 2];
        [self.layer addAnimation:globalRotate forKey:@"rotate_hole"];

        CABasicAnimation *shadeLayerRotate1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        shadeLayerRotate1.duration = firstPartTime;
        shadeLayerRotate1.timingFunction = _timeFunc;
        shadeLayerRotate1.fromValue = [NSNumber numberWithDouble:0];
        shadeLayerRotate1.toValue = [NSNumber numberWithDouble:M_PI * 1.5];
        
        CABasicAnimation *shadeLayerRotate2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        shadeLayerRotate2.duration = secondPartTime;
        shadeLayerRotate2.timingFunction = _timeFunc;
        shadeLayerRotate2.beginTime = firstPartTime;
        shadeLayerRotate2.fromValue = [NSNumber numberWithDouble:M_PI * 1.5];
        shadeLayerRotate2.toValue = [NSNumber numberWithDouble:M_PI * 2];
        
        CAAnimationGroup *rotateGroup = [CAAnimationGroup new];
        rotateGroup.animations = @[shadeLayerRotate1,shadeLayerRotate2];
        rotateGroup.duration = pathAnimationTime;
        rotateGroup.removedOnCompletion = NO;
        rotateGroup.repeatCount = CGFLOAT_MAX;
        [_shadeLayer addAnimation:rotateGroup forKey:@"rotate_animate"];
        
        CABasicAnimation *endFirst = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endFirst.timingFunction = _timeFunc;
        endFirst.duration = firstPartTime;
        endFirst.fromValue = [NSNumber numberWithDouble:1];
        endFirst.toValue = [NSNumber numberWithDouble:0.25];
        
        CABasicAnimation *endSecond = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endSecond.timingFunction = _timeFunc;
        endSecond.duration = secondPartTime;
        endSecond.beginTime = firstPartTime;
        endSecond.fromValue = [NSNumber numberWithDouble:0.25];
        endSecond.toValue = [NSNumber numberWithDouble:1];
        
        CAAnimationGroup *endGroup = [CAAnimationGroup new];
        endGroup.animations = @[endFirst,endSecond];
        endGroup.duration = pathAnimationTime;
        endGroup.removedOnCompletion = NO;
        endGroup.repeatCount = CGFLOAT_MAX;
        [_shadeLayer addAnimation:endGroup forKey:@"layer_animate"];
    }
}


@end
