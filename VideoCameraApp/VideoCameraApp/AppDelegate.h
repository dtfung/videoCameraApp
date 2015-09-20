//
//  AppDelegate.h
//  VideoCameraApp
//
//  Created by Donald Fung on 8/1/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "AlbumCollectionViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) CameraViewController *cameraView;
@property (strong, nonatomic) AlbumCollectionViewController *albumView;
@property (strong, nonatomic) UINavigationController *navigationController;


@end

