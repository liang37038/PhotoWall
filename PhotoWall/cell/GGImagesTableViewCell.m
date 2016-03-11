//
//  GGImagesTableViewCell.m
//  PhotoWall
//
//  Created by Richard Liang on 16/3/4.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import "GGImagesTableViewCell.h"

@implementation GGImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellViewModel:(GGImagesTableViewCellViewModel *)cellViewModel{
    _cellViewModel = cellViewModel;
    
    UIImageView *lastImageView;
    
    for (GGPhotoItem *photoItem in _cellViewModel.photoItems) {
        
        UIImageView *imageView = [self createEmptyImageView];
        imageView.image = photoItem.image;
        //计算图片实际高度
        CGFloat actualHeight = self.cellViewModel.picHeight;
        if (actualHeight == 0) {
            actualHeight = self.cellViewModel.standardHeight - self.cellViewModel.picGap;
        }
        
        CGFloat actualWidth = photoItem.displaySize.width * actualHeight / photoItem.displaySize.height;

        if (lastImageView) {
            imageView.frame = CGRectMake(CGRectGetMaxX(lastImageView.frame) + self.cellViewModel.picGap,
                                         0,
                                         actualWidth,
                                         actualHeight);
        }else{
            imageView.frame = CGRectMake(self.cellViewModel.picGap,
                                         0,
                                         actualWidth,
                                         actualHeight);
        }
        lastImageView = imageView;
        [self.contentView addSubview:imageView];
    }
}


- (UIImageView *)createEmptyImageView{
    UIImageView *tmpImageView = [[UIImageView alloc]init];
    tmpImageView.clipsToBounds = YES;
    tmpImageView.backgroundColor = [UIColor lightGrayColor];
    tmpImageView.userInteractionEnabled = YES;
    return tmpImageView;
}

- (void)prepareForReuse{
    for (UIView *subView in self.contentView.subviews) {
        if([subView isKindOfClass:[UIImageView class]]){
            UIImageView *imageView = (UIImageView *)subView;
            imageView.image = nil;
            [imageView removeFromSuperview];
        }else{
            [subView removeFromSuperview];
        }
    }
}

@end
