//
//  ViewController.m
//  weichatPhotoLib
//
//  Created by 朱辉 on 16/3/18.
//  Copyright © 2016年 JXX. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Layout.h"
#import "WDPhotoSelectedCell.h"
#import "WDImagePickerViewController.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WDImagePickerControllerDelegate>
{
    UICollectionView *photoCollectionView;
    NSMutableArray *selectedPhotos;
    NSMutableArray *selectedAssets;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel * title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, 20,self.view.tz_width, 60);
    title.text = @"iOS照片选择器";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:title];
    
    selectedPhotos = [NSMutableArray array];
    selectedAssets = [NSMutableArray array];
    [self configPhotoCollectionView];

}

-(void)configPhotoCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    
    
    photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_margin, 120, self.view.tz_width - 2 * _margin, 400) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    photoCollectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    photoCollectionView.contentInset = UIEdgeInsetsMake(4, 0, 0, 2);
    photoCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    [self.view addSubview:photoCollectionView];
    [photoCollectionView registerClass:[WDPhotoSelectedCell class] forCellWithReuseIdentifier:@"PhotoSelectedCell"];

}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WDPhotoSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoSelectedCell" forIndexPath:indexPath];
    if (indexPath.row == selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
    } else {
        cell.imageView.image = selectedPhotos[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == selectedPhotos.count)
        [self pickPhotoButtonClick:nil];
}


#pragma mark == 启动相册选择器 ==
- (void)pickPhotoButtonClick:(UIButton *)sender {
    
    // 1.0 照片选择器的初始化方法
    WDImagePickerViewController *imagePickerVc = [[WDImagePickerViewController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // 2.x 可以通过代理或者block两种方式获取选择的照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
//        [selectedPhotos addObjectsFromArray:photos];
//        [photoCollectionView reloadData];
//        photoCollectionView.contentSize = CGSizeMake(0, ((selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));

    }];
    
    
    // 3.0 在这里设置imagePickerVc的外观(不设为默认)
    /*
     imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
     imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
     */
    
    // 4.0 设置是否可以选择视频/原图
     imagePickerVc.allowPickingVideo = NO;
     imagePickerVc.allowPickingOriginalPhoto = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark  == WDImagePickerViewControllerDelegate  相册选择器的代理方法  ==

/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(WDImagePickerViewController *)picker {
    NSLog(@"cancel");
}

/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(WDImagePickerViewController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets{
    
    
    
    [selectedPhotos addObjectsFromArray:photos];
    [photoCollectionView reloadData];
    photoCollectionView.contentSize = CGSizeMake(0, ((selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));


    
    NSMutableArray *lastImages = [NSMutableArray new];    
     lastImages = [self scaleImageAndChangeToJPEG];
}

/// 用户选择好了视频
- (void)imagePickerController:(WDImagePickerViewController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    
    [selectedPhotos addObjectsFromArray:@[coverImage]];
    [photoCollectionView reloadData];
    photoCollectionView.contentSize = CGSizeMake(0, ((selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
}


#pragma mark  ==


-(NSMutableArray *)scaleImageAndChangeToJPEG
{

    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    CGSize siza = CGSizeMake(500.00f, 500.00f);
    
    
    for (UIImage *image in selectedPhotos) {
        
        CGFloat image_w  = image.size.width;
        CGFloat image_h  = image.size.height;
        CGFloat ratioW_H = image.size.width/image.size.height;
        CGFloat ratioH_W = image.size.height/image.size.width;
        
        
        if (image_w > image_h) {
            
            siza = CGSizeMake(500.0, 500.0*ratioH_W);
        } else {
            siza = CGSizeMake(500.0*ratioW_H, 500);
        }
        
        UIImage *newScaleImage = [self imageWithImageSimple:image scaledToSize:siza];
        UIImage *newImage =[ self pngToJPEGImage:newScaleImage];
        [imageArr addObject:newImage];
    }
    
    
    return imageArr;
}

#pragma ==图片裁剪==
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark === 转换格式 ===
-(UIImage*)pngToJPEGImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image,0.6);
    UIImage *newImage = [UIImage imageWithData:imageData];

    
    NSLog(@"imageData.length === %lu",(unsigned long)imageData.length/1000);
    
    
    return newImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
