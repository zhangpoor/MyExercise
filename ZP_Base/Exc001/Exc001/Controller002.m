//
//  Controller002.m
//  Exc001
//
//  Created by zhangpoor on 16/4/13.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "Controller002.h"
#import "Vc002CollectionCell.h"

@interface Controller002 ()<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property(nonatomic,strong)UICollectionView *clView;

@end

@implementation Controller002

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self initUI];
}

-(void)initUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing  = 0;
    layout.minimumLineSpacing       = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.clView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.clView.dataSource = self;
    self.clView.delegate = self;
    self.clView.showsHorizontalScrollIndicator = NO;
    self.clView.showsVerticalScrollIndicator = NO;
    self.clView.pagingEnabled = YES;
    self.clView.bounces = NO;
    self.clView.backgroundColor = [UIColor clearColor];
    [self.clView registerClass:[Vc002CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.clView];
    [self.clView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];

}


#pragma - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIndetifier = @"cell";
    Vc002CollectionCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIndetifier
                                              forIndexPath:indexPath];
    

    
    return cell;
}

- (void)    collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
