//
//  MultipleTagsView.m
//
//  Created by jiulong.zhou on 2017/6/10.
//  Copyright © 2017年 jiulong zhou. All rights reserved.
//  微信:627589430  email：zhoujiulong86@163.com

#import "MultipleTagsView.h"

@interface MultipleTagsView()
@property (strong ,nonatomic) NSMutableArray *viewList;//所有的按钮视图

@end

@implementation MultipleTagsView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self initData];
}
- (void)initData{
    self.verticalSpace = 15.0f;
    self.horizontalSpace = 15.0f;
    self.buttonHeight = 30.0f;
    self.column = 3;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChanageOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];

}
#pragma mark orientation change
- (void)deviceDidChanageOrientation:(NSNotification *)notifi{
    [self refreshLayout];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setTagsWithList:(NSArray *)listTags selectedTags:(NSArray *)selectedTags{
    self.selectedTags = [NSMutableArray arrayWithArray:selectedTags];
    CGFloat currentY = 0;
    CGFloat currentX = 0;
    for (NSString *name in listTags) {
        NSUInteger i = [listTags indexOfObject:name];
        UIButton *button = nil;
            //already have button view,reuse
        if (listTags.count == self.viewList.count) {
            button = self.viewList[i];
            button.tag = i;
            [button setTitle:name forState:UIControlStateNormal];
        }else{
            
            button = [self newBtn];
            [self.viewList addObject:button];
            button.tag = i;
            [button setTitle:name forState:UIControlStateNormal];
            [self addSubview:button];
        }

        for (NSString *title in selectedTags) {
            if ([title isEqualToString:name]) {
                button.selected = YES;
                break;
            }
        }

        //button position
        [self layoutButton:button currentX:&currentX currentY:&currentY];

        //button 样式
        if ([_delegate respondsToSelector:@selector(buttonViewUI:button:)]) {
            [_delegate buttonViewUI:self button:button];
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }
    }
    self.height =  currentY + self.verticalSpace*2 + self.buttonHeight;
    self.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.height);
    
}


/**
 按钮视图的位置设置

 @param button 按钮对象
 @param currentX 当前x轴的坐标
 @param currentY Y轴坐标
 */
- (void)layoutButton:(UIButton *)button currentX:(CGFloat *)currentX currentY:(CGFloat *)currentY
{
    CGFloat titleLabelSpace = 5;
    CGFloat maxWidth = self.bounds.size.width - self.horizontalSpace*2;
    CGFloat buttonWidth = 0;
    if (self.equalForTagWidth) {
        buttonWidth = (maxWidth - (self.column-1)*self.horizontalSpace)/self.column;
    }else{
        buttonWidth = [button.titleLabel.text boundingRectWithSize:CGSizeMake(maxWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil].size.width + titleLabelSpace*2; 
    }

    if (*currentX + self.horizontalSpace + buttonWidth + self.horizontalSpace <= self.bounds.size.width) {
        button.frame = CGRectMake(*currentX+self.horizontalSpace, *currentY, buttonWidth, self.buttonHeight);
        *currentX += self.horizontalSpace + buttonWidth;
    }else{
        *currentY += self.buttonHeight + self.verticalSpace;
        *currentX = 0;
        button.frame = CGRectMake(*currentX + self.horizontalSpace, *currentY, buttonWidth, self.buttonHeight);
        if (*currentX + self.horizontalSpace + buttonWidth + self.horizontalSpace <= maxWidth) {
            *currentX += self.horizontalSpace + buttonWidth;
        }else{
            *currentY += self.buttonHeight + self.verticalSpace;
        }
    }
}

- (void)refreshLayout{
    CGFloat currentY = 0;
    CGFloat currentX = 0;
    for (UIButton *button in self.viewList) {
        [self layoutButton:button currentX:&currentX currentY:&currentY];
    }
    self.height =  currentY + self.verticalSpace*2 + self.buttonHeight;
    self.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.height);
}
- (void)reset{
    for (UIButton *button in self.viewList) {
        if ([_delegate respondsToSelector:@selector(buttonViewUI:button:)]) {
            [_delegate buttonViewUI:self button:button];
        }
    }
}
- (NSMutableArray *)viewList{
    if (!_viewList) {
        _viewList = [NSMutableArray array];
    }
    return _viewList;
}

- (UIButton *)newBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)choose:(UIButton *)sender{
    //sender将要选中，先判断是否达到上限，如果达到，则不选中，给出提示；如果没达到上限则继续
    if(!sender.isSelected){
        if ([_delegate respondsToSelector:@selector(limitMaxSelectedTagsNum)]) {
            if ([_delegate limitMaxSelectedTagsNum] <= self.selectedTags.count) {
                return;
            }
        }
    }
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [self.selectedTags addObject:sender.titleLabel.text];
    }else{
        [self.selectedTags removeObject:sender.titleLabel.text];
    }
    if ([_delegate respondsToSelector:@selector(buttonViewUI:button:)]) {
        [_delegate buttonViewUI:self button:sender];
    }
    if ([_delegate respondsToSelector:@selector(selectView:button:)]) {
        [_delegate selectView:self button:sender];
    }
}

@end
