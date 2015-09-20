//
//  ViewController.h
//  VideoCameraApp
//
//  Created by Donald Fung on 8/1/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
#import "DAO.h"

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>


- (IBAction)camera:(id)sender;
@property (nonatomic, strong) NSMutableArray *thumbnails;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) UIPopoverController *pop;
@property (nonatomic, strong) UIImagePickerController *cameraUI;
@property (nonatomic, strong) NSURL *movieUrl;


@end

