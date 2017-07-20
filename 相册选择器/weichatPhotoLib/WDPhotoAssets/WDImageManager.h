//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@class WDAlbumModel,WDAssetModel;




@interface WDImageManager : NSObject

@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;

/**
 *  WDImageManager 单例
 *
 *  @return WDImageManager 对象
 */
+ (instancetype)manager;

/**
 *  是否得到相册授权
 *
 *  @return 返回YES 得到授权
 */
- (BOOL)authorizationStatusAuthorized;

/**
 *  获得相机-照片流(分组)
 *
 *  @param allowPickingVideo 是否获取视频
 *  @param completion        完成
 */
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo completion:(void (^)(WDAlbumModel *model))completion;

/**
 *  获取相册全部资源(分组)
 *
 *  @param allowPickingVideo 是否获取视频
 *  @param completion        完成
 */
- (void)getAllAlbums:(BOOL)allowPickingVideo completion:(void (^)(NSArray<WDAlbumModel *> *models))completion;

/**
 *  获取Asset数组
 *
 *  @param result            <#result description#>
 *  @param allowPickingVideo 是否获取视频资源
 *  @param completion        <#completion description#>
 */
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(NSArray<WDAssetModel *> *models))completion;

/**
 *  获得下标为index的单个照片
 *
 *  @param result            <#result description#>
 *  @param index             照片索引
 *  @param allowPickingVideo 是否获取视频
 *  @param completion        <#completion description#>
 */
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(WDAssetModel *model))completion;

/**
 *  获得照片
 *
 *  @param model      相册mdoel
 *  @param completion 完成
 */
- (void)getPostImageWithAlbumModel:(WDAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;

/**
 *  获取相片
 *
 *  @param asset      相片asset
 *  @param completion 完成
 */
- (void)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

/**
 *  获取图片
 *
 *  @param asset      图片asseet
 *  @param photoWidth 图片宽度
 *  @param completion <#completion description#>
 */
- (void)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

/**
 *  获取原图
 *
 *  @param asset      图片asset
 *  @param completion <#completion description#>
 */
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

/**
 *  获得视频
 *
 *  @param asset      <#asset description#>
 *  @param completion <#completion description#>
 */
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem * playerItem, NSDictionary * info))completion;


/**
 *  获得一组照片的大小
 *
 *  @param photos     <#photos description#>
 *  @param completion <#completion description#>
 */
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion;

@end
