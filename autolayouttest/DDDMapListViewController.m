//
//  DDDMapListViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 02/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapListViewController.h"
#import "DDDMapViewModel.h"
#import "DDDMainStoryboardIdentifiers.h"
#import "DDDMapListCollectionViewCell.h"

@interface DDDMapListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel		  *resultsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) DDDMapViewModel			  *viewModel;
@end

@implementation DDDMapListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.viewModel.mapSearchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	DDDMapListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDDMapListCollectionViewCellIdentifier forIndexPath:indexPath];
	MKMapItem *mapItem = self.viewModel.mapSearchResults[indexPath.row];
	[cell updateWithModel:mapItem];
	return cell;
}
#pragma - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}


@end
