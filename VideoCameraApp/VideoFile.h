//
//  VideoFile.h
//  VideoCameraApp
//
//  Created by Donald Fung on 8/3/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface VideoFile : NSObject

@property (nonatomic, retain) NSData *thumbnail;
@property (nonatomic, retain) NSData *videoPath;

-(instancetype)initWithName:(NSData*)thumbnail andVideoPath:(NSData *)videoPath;

@end
