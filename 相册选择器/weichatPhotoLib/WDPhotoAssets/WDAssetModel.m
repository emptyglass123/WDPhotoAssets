//
//  AppDelegate.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//
#import "WDAssetModel.h"

@implementation WDAssetModel


/**
 *  <#Description#>
 *
 *  @param asset <#asset description#>
 *  @param type  <#type description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)modelWithAsset:(id)asset type:(WDAssetModelMediaType)type{
    WDAssetModel *model = [[WDAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

/**
 *  <#Description#>
 *
 *  @param asset      <#asset description#>
 *  @param type       <#type description#>
 *  @param timeLength <#timeLength description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)modelWithAsset:(id)asset type:(WDAssetModelMediaType)type timeLength:(NSString *)timeLength {
    WDAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end



@implementation WDAlbumModel










@end