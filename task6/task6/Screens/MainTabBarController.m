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
#import "GalleryCollectionController.h"

@interface MainTabBarController ()

@property (nonatomic, strong) UINavigationController *infoController;
@property (nonatomic, strong) UINavigationController *homeController;
@property (nonatomic, strong) UINavigationController *galleryController;
@end

@implementation MainTabBarController

- (UINavigationController *)galleryController {
    if(!_galleryController) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _galleryController = [[UINavigationController alloc] initWithRootViewController:[[GalleryCollectionController alloc] initWithCollectionViewLayout:layout]];
        _galleryController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"gallery_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"gallery_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _galleryController;
}

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
        _homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"home_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _homeController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSLog(@"%@", [NSFileManager.defaultManager contentsOfDirectoryAtPath:NSDocumentDirectory error:nil]);
    
//    NSLog(@"%@", urls);
//    self.homeController = [HomeController new];
    
    
    
    
    
    
    self.viewControllers = @[self.infoController, self.galleryController, self.homeController];
    self.selectedIndex = 1;
}

@end
