//
//  AlbumCollectionViewController.h
//  VideoCameraApp
//
//  Created by Donald Fung on 8/2/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
#import "CameraViewController.h"
#import "VideoFile.h"
#import "DAO.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AlbumCollectionViewController : UICollectionViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *album;
@property (nonatomic, retain) CameraViewController *cameraThumnails;
@property (nonatomic, retain) DAO *dao;
@property (nonatomic, retain) NSURL *URL;
@end
