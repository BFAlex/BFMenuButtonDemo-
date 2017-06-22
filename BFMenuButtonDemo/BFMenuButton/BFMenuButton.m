//
//  BFMenuButton.m
//  BFMenuButtonDemo
//
//  Created by Readboy_BFAlex on 2017/6/22.
//  Copyright © 2017年 Readboy_BFAlex. All rights reserved.
//

#import "BFMenuButton.h"

#define kMenuCellID @"BFMenuCellID"

@interface BFMenuButton () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_menuTableView;
    UIImage *_image;
    
}
// 数据源
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) UIImage *btnImage;

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicateImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImgConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicateImgWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@end

@implementation BFMenuButton

#pragma mark - Propery

- (NSArray *)dataSource {
    if (!_dataSource) {
        // Sample Code
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            [arr addObject:[NSString stringWithFormat:@"菜单项%d", i]];
        }
        
//        _dataSource = [[NSArray alloc] init];
        _dataSource = arr;
    }
    
    return _dataSource;
}

#pragma mark - Public

+ (instancetype)menuButtonWithFrame:(CGRect)frame andImage:(UIImage *)img {
    BFMenuButton *btn = [[[NSBundle mainBundle] loadNibNamed:@"BFMenuButton" owner:nil options:nil] lastObject];
    if (btn) {
        btn.frame = frame;
        btn.btnImage = img;
        [btn setupView];
    }
    
    return btn;
}

- (void)setupView {
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1;
    
//    [self setupMenuButtonImage:self.btnImage];
    [self setupMenuButtonImage:[UIImage imageNamed:@"btnImage"]];
}

- (void)setupMenuButtonImage:(UIImage *)img {
    self.indicateImg.image = img;
    if (img) {
        self.indicateImgWidthConstraint.constant = self.bounds.size.height - self.topImgConstraint.constant * 2;
    } else {
        self.indicateImgWidthConstraint.constant = 0;
    }
}

- (void)setupMenuTableView {
    
    if (self.bounds.size.height == self.superview.bounds.size.height) {
        // 需要在父视图的上一级添加菜单
        CGFloat x = self.superview.frame.origin.x;
        CGFloat y = self.superview.frame.origin.y + self.frame.size.height;
        CGFloat width = self.bounds.size.width;
        // 菜单高度是按钮高度的三倍
        CGFloat height = self.bounds.size.height*3;
        
        CGRect tableRect = CGRectMake(x, y, width, height);
        _menuTableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
        
        [self.superview.superview addSubview:_menuTableView];
    } else {
        // 在父视图中添加菜单
        CGFloat x = self.frame.origin.x;
        CGFloat y = self.frame.origin.y + self.frame.size.height;
        CGFloat width = self.bounds.size.width;
        // 菜单高度是按钮高度的三倍
        CGFloat height = self.bounds.size.height*3;
        
        CGRect tableRect = CGRectMake(x, y, width, height);
        _menuTableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
        
        [self.superview addSubview:_menuTableView];
    }
    
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.userInteractionEnabled = true;
    _menuTableView.scrollEnabled = true;
    _menuTableView.showsVerticalScrollIndicator = true;
}

#pragma mark - Private

#pragma mark - UITableView Delegate && DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kMenuCellID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s%d", __func__, __LINE__);
//    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
//        NSString *item = [self.dataSource objectAtIndex:indexPath.row];
//        [self.delegate didSelectItem:item];
//    }
    self.menuLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    // 选择后关闭菜单栏
    [self clickMenuBtn:nil];
}

#pragma mark - Action

- (IBAction)clickMenuBtn:(UIButton *)sender {
    NSLog(@"%s%d", __func__, __LINE__);
    
    if (_menuTableView) {
        NSLog(@"移除菜单选择");
        [_menuTableView removeFromSuperview];
        _menuTableView = nil;
    } else {
        NSLog(@"添加菜单选择");
        [self setupMenuTableView];
    }
}

@end
