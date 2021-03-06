//
//  AppDelegate.m
//  task6
//
//  Created by Uladzislau on 6/18/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialViewController.h"
#import "MainTabBarController.h"
#import "UIColor+HEX.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold]};
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].barTintColor = [UIColor rsschoolYellowColor];
    
    if (@available(iOS 13.0, *)) {
    } else {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupInitialScreen) name:InitialScreenRequiredNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupMainScreen) name:MainScreenRequiredNotification object:nil];
    
        self.window = [UIWindow new];
        self.window.rootViewController = [InitialViewController new];
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

#pragma mark - Root VC switching

- (void)setupInitialScreen {
    [UIView animateWithDuration:0.2f animations:^{
        self.window.rootViewController = [InitialViewController new];
    }];
}

- (void)setupMainScreen {
    [UIView animateWithDuration:0.2f animations:^{
        self.window.rootViewController = [MainTabBarController new];
    }];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)){
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0)){
}


@end
