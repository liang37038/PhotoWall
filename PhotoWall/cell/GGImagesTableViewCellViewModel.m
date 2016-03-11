//
//  GGImagesTableViewCellViewModel.m
//  PhotoWall
//
//  Created by Richard Liang on 16/3/4.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import "GGImagesTableViewCellViewModel.h"

#define SCREEN_WIDTH    [[UIScreen mainScreen]bounds].size.width

@interface GGImagesTableViewCellViewModel()

@property (assign, nonatomic) CGFloat tmpPicTotalWidth;

@end

@implementation GGImagesTableViewCellViewModel

- (instancetype)init{
    if (self = [super init]) {
        _picGap = 10;
        _picTotalWidth = (SCREEN_WIDTH - 2 * _picGap);
        _standardHeight = _picTotalWidth/2;
        _referenceWidth = _standardHeight*4/3;
        _photoItems = [NSMutableArray array];
    }
    return self;
}

- (void)addPhotoItem:(GGPhotoItem *)photoItem{
    if (photoItem) {
        CGSize photoSize = CGSizeMake(photoItem.width.floatValue, photoItem.height.floatValue);
        CGSize imageSize = CGSizeResizeToHeight(photoSize, self.standardHeight);
        self.tmpPicTotalWidth += imageSize.width;
        photoItem.displaySize = imageSize;
        [self.photoItems addObject:photoItem];
    }
}

- (BOOL)allowMorePhotos{
    return self.tmpPicTotalWidth + (self.photoItems.count - 1) * self.picGap < self.referenceWidth;
}

- (void)makeCellHeightAdaptToScreenWidth{
    self.cellHeight = (SCREEN_WIDTH - 2* self.picGap - (self.photoItems.count - 1) * self.picGap) * (self.standardHeight) / (self.tmpPicTotalWidth);
    self.picHeight = self.cellHeight;
    self.cellHeight += self.picGap;
}

- (void)makeCellHeightEqualToStandardHeight{
    self.cellHeight = self.standardHeight;
}

- (UIImage *)zoomImageToAdaptCellHeight:(UIImage *)oldImage{
    return [self zoomImage:oldImage toHeight:self.cellHeight];
}

- (UIImage *)zoomImage:(UIImage *)oldImage toHeight:(CGFloat)newHeight{
    CGSize newImageSize = CGSizeResizeToHeight(oldImage.size, newHeight);
    return [self zoomImageToSize:newImageSize oldImage:oldImage];
}

- (UIImage *)zoomImageToSize:(CGSize)size oldImage:(UIImage *)oldImage{
    UIGraphicsBeginImageContext(size);
    [oldImage drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


CGSize CGSizeResizeToHeight(CGSize size, CGFloat height) {
    if (size.width == 0 || size.height == 0) {
        size.width = SCREEN_WIDTH;
    }else{
        size.width *= height / size.height;
    }
    size.height = height;
    return size;
}

@end
