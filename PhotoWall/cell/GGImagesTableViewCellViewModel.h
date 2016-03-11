//
//  GGImagesTableViewCellViewModel.h
//  PhotoWall
//
//  Created by Richard Liang on 16/3/4.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GGPhotoItem.h"

@interface GGImagesTableViewCellViewModel : NSObject

@property (assign, nonatomic) CGFloat picGap;
@property (assign, nonatomic) CGFloat picTotalWidth;
@property (assign, nonatomic) CGFloat referenceWidth;
@property (assign, nonatomic) CGFloat standardHeight;
@property (assign, nonatomic) CGFloat picHeight;

@property (assign, nonatomic) CGFloat cellHeight;

@property (strong, nonatomic) NSMutableArray<GGPhotoItem *> *photoItems;

- (void)addPhotoItem:(GGPhotoItem *)photoItem;

- (BOOL)allowMorePhotos;

- (UIImage *)zoomImageToAdaptCellHeight:(UIImage *)oldImage;
- (UIImage *)zoomImage:(UIImage *)oldImage toHeight:(CGFloat)newHeight;

/**
 *  将cell高度适应屏幕宽度缩放
 */
- (void)makeCellHeightAdaptToScreenWidth;

/**
 *  将cell高度限定为标准高度
 */
- (void)makeCellHeightEqualToStandardHeight;

@end
