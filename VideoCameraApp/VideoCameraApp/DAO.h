//
//  DAO.h
//  VideoCameraApp
//
//  Created by Donald Fung on 8/3/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoFile.h"
//#import "CameraViewController.h"


@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *cameraFiles;
@property (nonatomic, retain) NSMutableArray *databaseFiles;
//@property (nonatomic, retain) CameraViewController *cameraView;


+ (id)sharedManager;
- (void)addNewVideoFile;
- (void)deleteVideos;

@end
