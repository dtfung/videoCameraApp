//
//  ViewController.m
//  VideoCameraApp
//
//  Created by Donald Fung on 8/1/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "CameraViewController.h"


@interface CameraViewController ()

@end

@implementation CameraViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = (@"Camera");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.thumbnails = [[NSMutableArray alloc]init];
    self.dao = [DAO sharedManager];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)camera:(id)sender {
    
    if([self.pop isPopoverVisible]){
        [self.pop dismissPopoverAnimated:YES];
        self.pop = nil;
        return;
    }
    
    self.cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
        [self startCameraControllerFromViewController: self
                                        usingDelegate: self];
    }
    
    else {
        [self.cameraUI setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.cameraUI setAllowsEditing:TRUE];
        
        [self.cameraUI setDelegate:self];
        
        self.pop = [[UIPopoverController alloc]initWithContentViewController:self.cameraUI];
        
        [self.pop setDelegate:self];
        
        [self.pop presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    
}



- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    self.cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    self.cameraUI.allowsEditing = YES;
    
    self.cameraUI.delegate = delegate;
    
    [self presentViewController:self.cameraUI animated:YES completion:NULL];
    
    return YES;
    
}

//CANCEL FUNCTIONALITY WHEN INTERACTING WITH CAMERA ALBUM
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    [info allKeys];
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSString *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        NSLog(@"photo saved");
    }
    
    //Handle a movie capture
    if ([mediaType isEqualToString:@"public.movie"]) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL]path];
        self.movieUrl = [NSURL fileURLWithPath:moviePath];
        
        //GET THUMBNAIL
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.movieUrl options:nil];
        AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        NSError *err = NULL;
        CMTime time = CMTimeMake(1, 60);
        
        CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
        
        if (imgRef) {
            UIImage *thumbnail = [UIImage imageWithCGImage:imgRef];
            if (thumbnail) {
                
                NSLog(@"video saved");
                self.dao.cameraFiles = [[NSMutableArray alloc]init];
                
                [self bookmarkForURL:self.movieUrl];
                
                
                
                [self.dao.cameraFiles addObject:thumbnail];
                [self.dao addNewVideoFile];
            }
        }
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (NSData*)bookmarkForURL:(NSURL*)url {
    NSError* theError = nil;
    NSData* bookmark = [url bookmarkDataWithOptions:NSURLBookmarkCreationSuitableForBookmarkFile
                     includingResourceValuesForKeys:nil
                                      relativeToURL:nil
                                              error:&theError];
    if (theError || (bookmark == nil)) {
        // Handle any errors.
        return nil;
    }
    [self.dao.cameraFiles addObject:bookmark];
    return bookmark;
}




@end
