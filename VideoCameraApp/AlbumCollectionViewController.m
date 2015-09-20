//
//  AlbumCollectionViewController.m
//  VideoCameraApp
//
//  Created by Donald Fung on 8/2/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import "AlbumCollectionViewController.h"

@interface AlbumCollectionViewController ()

@end

@implementation AlbumCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = .5;
    layout.minimumLineSpacing = 0.5;
    (self = [super initWithCollectionViewLayout:layout]);
    
    self.title = @"Videos";
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.collectionView registerClass:[ImageCell class ]forCellWithReuseIdentifier:@"image"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self longPressGestureRecognizer];
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.dao = [DAO sharedManager];
    self.album = [self.dao.databaseFiles mutableCopy];
    NSLog(@"count is %lu", (unsigned long)self.album.count);
    return [self.album count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideoFile *currentfile = [self.album objectAtIndex:[indexPath row]];
    
    //Retrieve URL for a bookmark that was stored
    [self urlForBookmark:currentfile.videoPath];
    
    MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc] initWithContentURL:self.URL];
    [self presentMoviePlayerViewControllerAnimated:theMovie];
}

- (void)viewWillAppear:(BOOL)animated  {
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    imageCell.backgroundColor = [UIColor blueColor];
    
    VideoFile *currentfile = [self.album objectAtIndex:[indexPath row]];
    UIImage *thumbnailImageFromData = [UIImage imageWithData:[currentfile.thumbnail copy]];
    
    
    imageCell.thumbnailView.image = thumbnailImageFromData;
    
    return imageCell;
}

- (NSURL*)urlForBookmark:(NSData*)bookmark {
    BOOL bookmarkIsStale = NO;
    NSError* theError = nil;
    self.URL = [NSURL URLByResolvingBookmarkData:bookmark
                                         options:NSURLBookmarkResolutionWithoutUI
                                   relativeToURL:nil
                             bookmarkDataIsStale:&bookmarkIsStale
                                           error:&theError];
    
    if (bookmarkIsStale || (theError != nil)) {
        // Handle any errors
        return nil;
    }
    return self.URL;
}

- (void) longPressGestureRecognizer {
    UILongPressGestureRecognizer *longPress
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    //the minimum period for the gesture to be recognized
    longPress.minimumPressDuration = 2; //seconds
    //sets the delegate
    longPress.delegate = self;
    //attach the gesture recognizer to the view
    [self.collectionView addGestureRecognizer:longPress];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    //returns the coordinates of a single point in the veiw of a gesture
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    //returns the index path made with p as a parameter
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    //checks if the user has clicked on an index path of an item
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed and removes it from the row
        [self.album removeObjectAtIndex:indexPath.row];
        NSLog(@"video deleted from view");
        
        //delete item from the disk
        // DAO *dao = [DAO sharedManager];
        [self.dao deleteVideos];
        
        //reloads the data for the collection view
        [self viewWillAppear:YES];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
