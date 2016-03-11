//
//  GGPhotoItem.h
//  PhotoWall
//
//  Created by Richard Liang on 16/3/4.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GGPhotoItem : NSObject

@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSString *url;

//Demo用图片，真实情况用URL
@property (strong, nonatomic) UIImage *image;

@property (assign, nonatomic) CGSize displaySize;

@end
