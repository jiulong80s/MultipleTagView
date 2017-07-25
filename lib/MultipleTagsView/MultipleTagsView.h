//
//  MultipleTagsView.h
//
//  Created by jiulong.zhou on 2017/6/10.
//  Copyright © 2017年 jiulong zhou. All rights reserved.
//  微信:627589430  email：zhoujiulong86@163.com

#import <UIKit/UIKit.h>
@class MultipleTagsView;
@protocol TagsViewDelegate<NSObject>
@optional
//限制继续选中
- (NSUInteger)limitMaxSelectedTagsNum;
//选中或取消选中操作
- (void)selectView:(MultipleTagsView*)view button:(UIButton *)sender;
//设置视图中按钮的界面显示元素，使用button对象进行设置
- (void)buttonViewUI:(MultipleTagsView *)MultipleTagsView button:(UIButton *)button;
@end

@interface MultipleTagsView : UIView

@property (assign ,nonatomic) CGFloat height; //设置listdata后获取的视图总高度
@property (assign ,nonatomic) CGFloat verticalSpace; //上下间隔，默认15
@property (assign ,nonatomic) CGFloat horizontalSpace; //左右间隔，默认15
@property (assign ,nonatomic) CGFloat buttonHeight;//默认30
@property (assign ,nonatomic) BOOL equalForTagWidth;//按钮是否等宽
@property (assign ,nonatomic) int column;//如果是等宽的，设置列数，默认3列
@property (strong ,nonatomic) NSMutableArray *selectedTags;
@property (weak   ,nonatomic) id<TagsViewDelegate> delegate;

//设置前请把其他基础值设置好，如果不设置都为默认值
- (void)setTagsWithList:(NSArray *)listTags selectedTags:(NSArray *)selectedTags;
- (void)refreshLayout;
- (void)reset;
@end
