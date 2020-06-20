//
//  MainTabBarController.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "MainTabBarController.h"
#import "InfoTableController.h"
#import "HomeController.h"
//#import <Media

@interface MainTabBarController ()

@property (nonatomic, strong) UINavigationController *infoController;
@property (nonatomic, strong) UINavigationController *homeController;
@end

@implementation MainTabBarController

- (UINavigationController *)infoController {
    if(!_infoController) {
        _infoController = [[UINavigationController alloc] initWithRootViewController:[InfoTableController new]];
//        _infoController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"info_unselected"] tag:0];
//        _infoController.navigationItem.title = @"Info";
        
    }
    return _infoController;
}

- (UINavigationController *)homeController {
    if(!_homeController) {
        _homeController = [[UINavigationController alloc] initWithRootViewController: [HomeController new]];
    }
    return _homeController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSLog(@"%@", [NSFileManager.defaultManager contentsOfDirectoryAtPath:NSDocumentDirectory error:nil]);
    
//    NSLog(@"%@", urls);
//    self.homeController = [HomeController new];
    
    self.homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"home_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
    self.homeController.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    self.navigationItem.navigationBar.backgroundColor = [UIColor colorNamed:@"Yellow"];
    
    
    
    self.viewControllers = @[self.infoController, self.homeController];
    self.selectedIndex = 1;
}

@end
