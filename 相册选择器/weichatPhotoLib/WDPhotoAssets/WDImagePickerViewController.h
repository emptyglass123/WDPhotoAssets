//
//  WDImagePickerViewController.h
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

@protocol WDImagePickerControllerDelegate;

@interface WDImagePickerViewController : UINavigationController


/**
 *  初始化方法
 *
 *  @param maxImagesCount 相册列表最大列数
 *  @param delegate       代理
 *
 *  @return
 */
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<WDImagePickerControllerDelegate>)delegate;

/**
 *  最多可选择照片的数量，默认9
 */
@property (nonatomic, assign) NSInteger maxImagesCount;

/**
 *  默认为YES，如果设置为NO,原图按钮将隐藏，用户不能选择发送原图
 */
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;

/**
 *  默认为YES，如果设置为NO,用户将不能选择发送视频
 */
@property (nonatomic, assign) BOOL allowPickingVideo;

/**
 *  Appearance / 外观颜色
 */
@property (nonatomic, strong) UIColor *oKButtonTitleColorNormal;

@property (nonatomic, strong) UIColor *oKButtonTitleColorDisabled;

/**
 *  这个照片选择器不会自己dismiss，用户dismiss这个选择器的时候，会执行下面的handle
 *  如果用户没有选择发送原图,第二个数组将是空数组
 */
@property (nonatomic, copy) void (^didFinishPickingPhotosHandle)(NSArray<UIImage *> *photos,NSArray *assets);

@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,NSArray<NSDictionary *> *infos);

/**
 *  如果用户选择了一个视频，下面的handle会被执行
 *  如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
 */
@property (nonatomic, copy) void (^didFinishPickingVideoHandle)(UIImage *coverImage,id asset);

/**
 *  取消选择
 */
@property (nonatomic, copy) void (^imagePickerControllerDidCancelHandle)();

/**
 *  代理
 */
@property (nonatomic, weak) id<WDImagePickerControllerDelegate> pickerDelegate;



- (void)showAlertWithTitle:(NSString *)title;

- (void)showProgressHUD;

- (void)hideProgressHUD;


@end





@protocol WDImagePickerControllerDelegate <NSObject>
@optional
// The picker does not dismiss itself; the client dismisses it in these callbacks.
// Assets will be a empty array if user not picking original photo.
// 这个照片选择器不会自己dismiss，用户dismiss这个选择器的时候，会走下面的回调
// 如果用户没有选择发送原图,Assets将是空数组
- (void)imagePickerController:(WDImagePickerViewController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets;
- (void)imagePickerController:(WDImagePickerViewController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos;
- (void)imagePickerControllerDidCancel:(WDImagePickerViewController *)picker;

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(WDImagePickerViewController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset;
@end


@interface WDAlbumPickerController : UIViewController

@end

