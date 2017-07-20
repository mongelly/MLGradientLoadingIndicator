//
//  MLGradientLoadingIndicator.h
//  MLGradientLoadingIndicatorDemo
//
//  Created by MogLu on 20/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLGradientLoadingIndicator : UIView

@property (nonatomic) CGFloat annulusWidth;
@property (nonatomic ) NSArray *gradientColors;
@property (nonatomic,readonly) bool isAnimating;

-(instancetype)initWithRaduis:(CGFloat) radius setAnnulusWidth:(CGFloat) width setGradientColors:(NSArray*) colors;

-(void)showInViewcenter:(UIView*) superview;

-(void)starAnimation;

-(void)stopAnimation;

@end
