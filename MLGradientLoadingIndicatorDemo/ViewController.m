//
//  ViewController.m
//  MLGradientLoadingIndicatorDemo
//
//  Created by MogLu on 20/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "ViewController.h"
#import "MLGradientLoadingIndicator.h"

@interface ViewController ()

@end

@implementation ViewController
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showButtonTouchUpInside:(id)sender
{
    NSArray *gradientColors = [[NSArray alloc] initWithObjects:(__bridge id)UIColor.blueColor.CGColor,(__bridge id)UIColor.greenColor.CGColor, nil];    
    MLGradientLoadingIndicator *loadingIndicator = [[MLGradientLoadingIndicator alloc]initWithRaduis:30 setAnnulusWidth:5 setGradientColors:gradientColors];
    [loadingIndicator showInViewcenter:self.view];
    
}

@end
