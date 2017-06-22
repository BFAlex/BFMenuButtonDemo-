//
//  ViewController.m
//  BFMenuButtonDemo
//
//  Created by Readboy_BFAlex on 2017/6/22.
//  Copyright © 2017年 Readboy_BFAlex. All rights reserved.
//

#import "ViewController.h"
#import "BFMenuButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuBtnContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BFMenuButton *menuBtn = [BFMenuButton menuButtonWithFrame:self.menuBtnContainer.bounds andImage:nil];
    [self.menuBtnContainer addSubview:menuBtn];
}


@end
