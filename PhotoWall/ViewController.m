//
//  ViewController.m
//  PhotoWall
//
//  Created by Richard Liang on 16/3/4.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import "ViewController.h"
#import "GGImagesTableViewCell.h"
#import "GGPhotoItem.h"
#import "UIImage+Color.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *photoArray;
@property (strong, nonatomic) NSMutableArray *cellViewModelsArray;

@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFadeData];
}

- (void)createFadeData{
    NSArray *randomColors = @[
                              [UIColor lightGrayColor],
                              [UIColor greenColor],
                              [UIColor blueColor],
                              [UIColor redColor],
                              [UIColor yellowColor],
                              [UIColor purpleColor]
                              ];
    
    NSInteger randomItemNumber = arc4random() % 30;
    
    for (NSInteger i = 0; i < randomItemNumber; i++) {
        GGPhotoItem *item = [[GGPhotoItem alloc]init];
        NSInteger randomColorIndex = arc4random() % randomColors.count;
        item.image = [UIImage imageWithColor:[randomColors objectAtIndex:randomColorIndex]];
        item.width = @([self getRandomNumber:400 to:1080]);
        item.height = @([self getRandomNumber:400 to:1080]);
        [self.photoArray addObject:item];
    }
    
    GGImagesTableViewCellViewModel *firstCellViewModel = nil;
    
    for (GGPhotoItem * item in self.photoArray) {
        if (!firstCellViewModel) {
            firstCellViewModel = [[GGImagesTableViewCellViewModel alloc]init];
            [firstCellViewModel addPhotoItem:item];
        }else{
            if (![firstCellViewModel allowMorePhotos]) {
                [firstCellViewModel makeCellHeightAdaptToScreenWidth];
                firstCellViewModel = [[GGImagesTableViewCellViewModel alloc]init];
                [firstCellViewModel addPhotoItem:item];
            }else{
                [firstCellViewModel addPhotoItem:item];
            }
        }
        [self.cellViewModelsArray addObject:firstCellViewModel];
    }
}

- (int) getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter
- (NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

- (NSMutableArray *)cellViewModelsArray{
    if (!_cellViewModelsArray) {
        _cellViewModelsArray = [NSMutableArray array];
    }
    return _cellViewModelsArray;
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellViewModelsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GGImagesTableViewCellViewModel *cellViewModel = [self.cellViewModelsArray objectAtIndex:indexPath.row];
    return cellViewModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GGImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imagesCell" forIndexPath:indexPath];
    
    GGImagesTableViewCellViewModel *cellViewModel = [self.cellViewModelsArray objectAtIndex:indexPath.row];
    
    cell.cellViewModel = cellViewModel;

    return cell;
}

@end
