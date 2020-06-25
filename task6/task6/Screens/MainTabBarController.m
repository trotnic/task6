//
//  MainTabBarController.m
//  task6
//
//  Created by Uladzislau on 6/19/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeController.h"
#import "GalleryCollectionController.h"
#import "InfoCollectionController.h"

@interface MainTabBarController ()

@property (nonatomic, strong) UINavigationController *homeController;
@property (nonatomic, strong) UINavigationController *galleryController;
@property (nonatomic, strong) UINavigationController *infoController;
@end

@implementation MainTabBarController

#pragma mark - Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[self.infoController, self.galleryController, self.homeController];
    self.selectedIndex = 1;
}

#pragma mark - Getters

- (UINavigationController *)galleryController {
    if(!_galleryController) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _galleryController = [[UINavigationController alloc] initWithRootViewController:[[GalleryCollectionController alloc] initWithCollectionViewLayout:layout]];
        _galleryController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                      image:[[UIImage imageNamed:@"gallery_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                              selectedImage:[[UIImage imageNamed:@"gallery_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _galleryController;
}

- (UINavigationController *)homeController {
    if(!_homeController) {
        _homeController = [[UINavigationController alloc] initWithRootViewController: [HomeController new]];
        _homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                   image:[[UIImage imageNamed:@"home_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                           selectedImage:[[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _homeController;
}

- (UINavigationController *)infoController {
    if(!_infoController) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _infoController = [[UINavigationController alloc] initWithRootViewController:[[InfoCollectionController alloc] initWithCollectionViewLayout:layout]];
        _infoController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                   image:[[UIImage imageNamed:@"info_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                           selectedImage:[[UIImage imageNamed:@"info_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _infoController;
}

@end
