
//
//  TabBarView.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/16.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "TabBarView.h"

#define DEF_TAB_ITEM_COUNT 3

UIButton *_shadeBtn;

@implementation TabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
   
        /// tabBar上每个item的宽度
        float itemWidth = DEF_SCREEN_WIDTH / DEF_TAB_ITEM_COUNT;
        
        /// 创建每个item
        for (int i = 0; i < DEF_TAB_ITEM_COUNT; i++)
        {
            UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, DEF_HEIGHT(self))];
            itemButton.adjustsImageWhenHighlighted = NO;
            
            UIButton *itemButtonicon = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth * i + 30, 8, 40, 40)];

            if ([Person getInstance].typeNumber == 1)
            {
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item%d", i+1]] forState:UIControlStateNormal];
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item%d_Select", i+1]] forState:UIControlStateSelected];
            }
            else if ([Person getInstance].typeNumber == 9)
            {
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item_2%d", i+1]] forState:UIControlStateNormal];
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item_2%d_Select", i+1]] forState:UIControlStateSelected];
            }
            else if ([Person getInstance].typeNumber == 91)
            {
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item_3%d", i+1]] forState:UIControlStateNormal];
                [itemButtonicon setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Tab_Item_3%d_Select", i+1]] forState:UIControlStateSelected];
            }

            [itemButtonicon addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
            itemButtonicon.tag = i + 100;
            [self addSubview:itemButtonicon];

            if (i == 100)
            {
                itemButton.selected = YES;
                itemButtonicon.selected = YES;
            }
        }
        
        _shadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shadeBtn.frame = CGRectMake(0, 47, itemWidth, 2);
        _shadeBtn.backgroundColor = [Person getColor];
        [self addSubview:_shadeBtn];
        [DEF_NOTIFICATION addObserver:self selector:@selector(changIcon:) name:@"changIcon" object:nil];
    }
    return self;
}

- (void)itemClick:(UIButton *)item
{
    for (UIButton *button in self.subviews)
    {
        button.selected = NO;
    }
    item.selected = YES;
    
    [self moveShadeBtn:item];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarView:didSelectAtIndex:)])
    {
        [self.delegate tabBarView:self didSelectAtIndex:item.tag];
    }
}

//背景按钮移动
- (void)moveShadeBtn:(UIButton*)btn
{
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
         CGRect frame = _shadeBtn.frame;
         if (btn.tag == 3)
         {
             frame.origin.x = 0;
         }
         else
         {
             frame.origin.x = btn.frame.origin.x - 30;
         }
         _shadeBtn.frame = frame;
         
     } completion:^(BOOL finished){
     }];
}


- (void)changIcon:(NSNotification *)not
{
    for (UIButton *button in self.subviews)
    {
        button.selected = NO;
    }

    NSInteger t = [not.object integerValue];
    NSLog(@"t  =%ld",(long)t);
    if (t == 0)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:100];
        [self moveShadeBtn:btn];
        btn.selected = YES;
    }
    else if (t == 1)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:101];
        [self moveShadeBtn:btn];
        btn.selected = YES;
    }
    else if (t == 2)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:102];
        [self moveShadeBtn:btn];
        btn.selected = YES;
    }
    [DEF_NOTIFICATION removeObserver:self name:@"changIcon" object:nil];
}


//- (void)changeTabIcon:(NSInteger)index
//{
//    for (UIButton *button in self.subviews)
//    {
//        button.selected = NO;
//    }
//    
//    NSLog(@"t  =%ld",(long)index);
//    if (index == 0)
//    {
//        UIButton *btn = (UIButton *)[self viewWithTag:100];
//        [self moveShadeBtn:btn];
//        btn.selected = YES;
//    }
//    else if (index == 1)
//    {
//        UIButton *btn = (UIButton *)[self viewWithTag:101];
//        [self moveShadeBtn:btn];
//        btn.selected = YES;
//    }
//    else if (index == 2)
//    {
//        UIButton *btn = (UIButton *)[self viewWithTag:102];
//        [self moveShadeBtn:btn];
//        btn.selected = YES;
//    }
//}






@end
