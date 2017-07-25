# MultipleTagsView

Multi-row columns of multiple button views.
1. Specify a fixed number of columns to be allocated according to the view width (固定显示列数，tag的宽度将根据MultipleTagsView的宽度均分)
2. Do not specify the number of columns, and the length of the title of the button will automatically match the width.(不指定列数，tag的宽度根据它的title自适配)

效果图：![效果图](http://chuantu.biz/t5/149/1500977361x2728329173.png "效果图")

```
// 微信：627589430 email:zhoujiulong86@163.com

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

- (void)selectView:(MultipleTagsView *)view button:(UIButton *)sender\{
    //todo:处理选中后的处理事项
      NSLog(@"选中第%d个tag,总共选中了%d个。",(int)(sender.tag),(int)(view.selectedTags.count));
    }
    @end
```