//
//  ViewController.m
//  task6
//
//  Created by Uladzislau on 6/18/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "ViewController.h"
#import "SquareView.h"
#import "CircleView.h"
#import "TriangleView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.squareView = [[SquareView alloc] initWithFrame:CGRectMake(100, 100, 70, 70)];
    self.triangleView = [[TriangleView alloc] initWithFrame:CGRectMake(180, 100, 70, 70)];
    self.circleView = [[CircleView alloc] initWithFrame:CGRectMake(260, 100, 70, 70)];
    
    
    [self.view addSubview:self.squareView];
    [self.view addSubview:self.triangleView];
    [self.view addSubview:self.circleView];
    
    self.triangleView.center = CGPointMake(135, 135);
    
    self.triangleView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
}


@end
