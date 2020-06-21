//
//  AppDelegate.m
//  task6
//
//  Created by Uladzislau on 6/18/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialViewcontroller.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupInitialScreen) name:@"initialScreenRequiredNotification" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupMainScreen) name:@"mainScreenRequiredNotification" object:nil];
    self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    self.window.rootViewController = [InitialViewcontroller new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupInitialScreen {
    NSLog(@"lolkek");
    [UIView animateWithDuration:0.2f animations:^{
//        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.window.rootViewController = [InitialViewcontroller new];
//        }];
    }];
    
}

- (void)setupMainScreen {
    NSLog(@"cheburek");
    [UIView animateWithDuration:0.2f animations:^{
//        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.window.rootViewController = [MainTabBarController new];
//        }];
    }];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)){
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0)){
}


@end
