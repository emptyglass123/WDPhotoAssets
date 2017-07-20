//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TZAssetCellTypePhoto = 0,
    TZAssetCellTypeLivePhoto,
    TZAssetCellTypeVideo,
    TZAssetCellTypeAudio,
} WDAssetCellType;

@class WDAssetModel;
@interface WDAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (nonatomic, strong) WDAssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) WDAssetCellType type;

@end


@class WDAlbumModel;

@interface WDAlbumCell : UITableViewCell

@property (nonatomic, strong) WDAlbumModel *model;

@end
