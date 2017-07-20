//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import <UIKit/UIKit.h>

@class WDAlbumModel;


@interface WDPhotoPickerController : UIViewController

@property (nonatomic, strong) WDAlbumModel *model;

@end
