//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    TZAssetModelMediaTypePhoto = 0,
    TZAssetModelMediaTypeLivePhoto,
    TZAssetModelMediaTypeVideo,
    TZAssetModelMediaTypeAudio
    
} WDAssetModelMediaType;


@class PHAsset; /*Use PHAsset from the Photos framework instead*/
/**
 *  照片示例模型
 */
@interface WDAssetModel : NSObject

/**
 *  照片资源asset
 *  < PHAsset or ALAsset
 */
@property (nonatomic, strong) id asset;

/**
 *  图片资源的状态
 *  默认 是NO
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 *  媒体资源类型
 *  照片/视频
 */
@property (nonatomic, assign) WDAssetModelMediaType type;

/**
 *  时长
 */
@property (nonatomic, copy) NSString *timeLength;

/**
 *  初始化照片模型
 *
 *  @param asset PHAsset/ALAsset实例
 *  @param type  资源类型
 *
 *  @return 初始化一个照片模型
 */
+ (instancetype)modelWithAsset:(id)asset type:(WDAssetModelMediaType)type;

+ (instancetype)modelWithAsset:(id)asset type:(WDAssetModelMediaType)type timeLength:(NSString *)timeLength;

@end



@class PHFetchResult;

/**
 *  相册分组示例模型
 */
@interface WDAlbumModel : NSObject

/**
 *  相册分组名称
 */
@property (nonatomic, strong) NSString *name;     ///< The album name

/**
 *  当前分组下照片数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  < PHFetchResult<PHAsset> or 
 *  ALAssetsGroup<ALAsset>
 */
@property (nonatomic, strong) id result;








@end