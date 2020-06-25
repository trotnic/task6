//
//  SceneDelegate.m
//  task6
//
//  Created by Uladzislau on 6/18/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

#import "SceneDelegate.h"
#import "InitialViewController.h"
#import "MainTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupInitialScreen) name:@"initialScreenRequiredNotification" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setupMainScreen) name:@"mainScreenRequiredNotification" object:nil];
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = [InitialViewController new];
    [self.window makeKeyAndVisible];
}

- (void)setupInitialScreen {
    [UIView animateWithDuration:0.2f animations:^{
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.window.rootViewController = [InitialViewController new];
        }];
    }];
}

- (void)setupMainScreen {
    [UIView animateWithDuration:0.2f animations:^{
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.window.rootViewController = [MainTabBarController new];
        }];
    }];
}


- (void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
