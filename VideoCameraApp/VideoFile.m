//
//  VideoFile.m
//  VideoCameraApp
//
//  Created by Donald Fung on 8/3/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import "VideoFile.h"

@implementation VideoFile

-(instancetype)initWithName:(NSData*)thumbnail andVideoPath:(NSData *)videoPath {
    self = [super init];
    if (self) {
        self.thumbnail = thumbnail;
        self.videoPath = videoPath;
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)encoder {
    [encoder encodeObject:[self thumbnail] forKey:@"thumbnail"];
    [encoder encodeObject:[self videoPath] forKey:@"videoPath"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        [self setThumbnail:[decoder decodeObjectForKey:@"thumbnail"]];
        [self setVideoPath:[decoder decodeObjectForKey:@"videoPath"]];
    }
    return self;
}


@end
