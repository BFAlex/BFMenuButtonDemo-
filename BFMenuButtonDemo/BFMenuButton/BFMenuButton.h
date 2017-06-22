//
//  BFMenuButton.h
//  BFMenuButtonDemo
//
//  Created by Readboy_BFAlex on 2017/6/22.
//  Copyright © 2017年 Readboy_BFAlex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFMenuButtonDelegate <NSObject>

@optional
- (void)didSelectItem:(NSString *)item;

@end

@interface BFMenuButton : UIView

@property (nonatomic, weak) id<BFMenuButtonDelegate> delegate;

+ (instancetype)menuButtonWithFrame:(CGRect)frame andImage:(UIImage *)img;
- (void)setupMenuButtonImage:(UIImage *)img;

@end
