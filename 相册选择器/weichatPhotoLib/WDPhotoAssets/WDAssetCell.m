//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import "WDAssetCell.h"
#import "WDAssetModel.h"
#import "UIView+Layout.h"
#import "WDImageManager.h"
#import "WDImagePickerViewController.h"

@interface WDAssetCell ()
/**
 *  图片imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 *  选中/取消选中 标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

/**
 *  视频信息view
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 *  视频时长
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLength;

@end

@implementation WDAssetCell

- (void)awakeFromNib {
    self.timeLength.font = [UIFont boldSystemFontOfSize:11];
}

- (void)setModel:(WDAssetModel *)model {
    _model = model;
    [[WDImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.tz_width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        self.imageView.image = photo;
        
    }];
    self.selectPhotoButton.selected = model.isSelected;
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@"photo_sel_photoPickerVc"] : [UIImage imageNamed:@"photo_def_photoPickerVc"];
    self.type = TZAssetCellTypePhoto;
    if (model.type == TZAssetModelMediaTypeLivePhoto)
        
        self.type = TZAssetCellTypeLivePhoto;
    
    else if (model.type == TZAssetModelMediaTypeAudio)
        
        self.type = TZAssetCellTypeAudio;
    
    else if (model.type == TZAssetModelMediaTypeVideo) {
        
        self.type = TZAssetCellTypeVideo;
        
        self.timeLength.text = model.timeLength;
    }
}


/**
 *  设置资源类型
 *  1.图片照片格式下隐藏_bottomView
 *  2.视频资源下 _selectImageView 和 _selectPhotoButton 显示
 *
 *  @param type 资源类型
 */
- (void)setType:(WDAssetCellType)type {
    _type = type;
    if (type == TZAssetCellTypePhoto || type == TZAssetCellTypeLivePhoto) {
        _selectImageView.hidden = NO;
        _selectPhotoButton.hidden = NO;
        _bottomView.hidden = YES;
    } else {
        _selectImageView.hidden = YES;
        _selectPhotoButton.hidden = YES;
        _bottomView.hidden = NO;
    }
}

/**
 *  选中/取消 图片选择
 *
 *  @param sender <#sender description#>
 */
- (IBAction)selectPhotoButtonClick:(UIButton *)sender {
    
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectImageView.image = sender.isSelected ? [UIImage imageNamed:@"photo_sel_photoPickerVc"] : [UIImage imageNamed:@"photo_def_photoPickerVc"];
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:TZOscillatoryAnimationToBigger];
    }
}

@end




@interface WDAlbumCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end

@implementation WDAlbumCell

- (void)awakeFromNib {
    self.posterImageView.clipsToBounds = YES;
}

- (void)setModel:(WDAlbumModel *)model {
    _model = model;
    
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",model.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [nameString appendAttributedString:countString];
    self.titleLable.attributedText = nameString;
    [[WDImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
        self.posterImageView.image = postImage;
    }];
}

/// For fitting iOS6
- (void)layoutSubviews {
    if (iOS7Later) [super layoutSubviews];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    if (iOS7Later) [super layoutSublayersOfLayer:layer];
}


@end