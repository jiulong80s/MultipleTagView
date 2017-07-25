//
//  ViewController.m
//  MutipleTagsView
//
//  Created by jiulong.zhou on 2017/7/25.
//  Copyright © 2017年 SEED. All rights reserved.
//

#import "ViewController.h"
#import "MultipleTagsView.h"
@interface ViewController ()<TagsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MultipleTagsView *tagsViewFirst = [[MultipleTagsView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
    [self.view addSubview:tagsViewFirst];
    tagsViewFirst.delegate = self;
    tagsViewFirst.buttonHeight = 35.0f;
    tagsViewFirst.equalForTagWidth = YES;
    NSArray *listTags = @[@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7",@"title8"];
    [tagsViewFirst setTagsWithList:listTags selectedTags:@[@"title2",@"title7"]];


    MultipleTagsView *tagsViewSecond = [[MultipleTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 150)];
    [self.view addSubview:tagsViewSecond];
    tagsViewSecond.delegate = self;
    tagsViewSecond.buttonHeight = 35.0f;
    tagsViewSecond.equalForTagWidth = NO;
    NSArray *listTags2 = @[@"title11",@"title2222",@"title333333333333333",@"title444444444",@"title5",@"title666666",@"title77777777777777777777777",@"title888"];
    [tagsViewSecond setTagsWithList:listTags2 selectedTags:nil];
}

#pragma mark MultipleTagsView Delegate
- (NSUInteger)limitMaxSelectedTagsNum{
    return 5;
}

- (void)buttonViewUI:(MultipleTagsView *)MultipleTagsView button:(UIButton *)button{
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    if (button.isSelected) {
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.layer.borderWidth = 0.5;
    }else{
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 0.5;
    }
}

- (void)selectView:(MultipleTagsView *)view button:(UIButton *)sender{
//todo:处理选中后的处理事项
    NSLog(@"选中第%d个tag,总共选中了%d个。",(int)(sender.tag),(int)(view.selectedTags.count));
}



@end
