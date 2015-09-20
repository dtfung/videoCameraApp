//
//  ImageCell.m
//  VideoCameraApp
//
//  Created by Donald Fung on 8/2/15.
//  Copyright © 2015 Donald Fung. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.thumbnailView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.thumbnailView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.thumbnailView.frame = self.contentView.bounds;
    
}

@end
