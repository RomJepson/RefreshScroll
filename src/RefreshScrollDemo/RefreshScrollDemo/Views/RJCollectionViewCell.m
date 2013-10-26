//
//  RJCollectionViewCell.m
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Rom Jepson. All rights reserved.
//

#import "RJCollectionViewCell.h"

@implementation RJCollectionViewCell

- (void)dealloc {
    [_imageView release];
    [_subtitle release];
    [super dealloc];
}

@end
