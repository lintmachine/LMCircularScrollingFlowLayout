//
//  LMCollectionViewController.m
//  LMLoadMoreDataSourceAdapter
//
//  Created by cdann on 6/25/14.
//

#import "LMCollectionViewController.h"
#import "LMTestCell.h"

@interface LMCollectionViewController()
@property (nonatomic) NSInteger cellCount;
@end

@implementation LMCollectionViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cellCount = 80;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellCount / (section + 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseIdentifier = [NSString stringWithFormat:@"Cell%ld", (long)indexPath.section];
    LMTestCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    return cell;
}

@end
