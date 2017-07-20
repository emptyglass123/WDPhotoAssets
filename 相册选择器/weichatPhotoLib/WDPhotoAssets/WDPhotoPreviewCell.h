//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import <UIKit/UIKit.h>

@class WDAssetModel;
@interface WDPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, strong) WDAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();

@end
