//
//  DAO.m
//  VideoCameraApp
//
//  Created by Donald Fung on 8/3/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import "DAO.h"


@implementation DAO

+ (id)sharedManager {
    
//    Call singleton
    static DAO *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(instancetype) init {
    if (self = [super init]) {
        [self loadAlreadyStoredFiles];
        
        return self;
    }
    else return nil;
}

- (void)loadAlreadyStoredFiles {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *encodedObject = [defaults objectForKey:@"GetStoredFiles"];
    
    if(encodedObject){
        self.databaseFiles = [NSKeyedUnarchiver unarchiveObjectWithData: encodedObject];
        return;
    }

}

- (void)addNewVideoFile {
    
    if (self.databaseFiles.count < 1) {
        NSLog(@"array initialized");
        self.databaseFiles = [[NSMutableArray alloc] init];
    }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *encodedObject;
    
        VideoFile *file = [[VideoFile alloc] init];
        file.videoPath =  [self.cameraFiles objectAtIndex:0];
        file.thumbnail =  UIImagePNGRepresentation ([self.cameraFiles objectAtIndex:1]);
        [self.databaseFiles addObject:file];
    
        encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.databaseFiles];
        [defaults setObject:encodedObject forKey:@"GetStoredFiles"];
        [defaults synchronize];
}

-(void)deleteVideos {
    // Archive after deletion
    DAO *dao = [DAO sharedManager];
    
    //encode objects
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:dao.databaseFiles];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"GetStoredFiles"];
    [defaults synchronize];
}

@end
