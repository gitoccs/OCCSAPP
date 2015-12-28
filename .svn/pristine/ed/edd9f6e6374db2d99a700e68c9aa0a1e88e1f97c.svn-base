//
//  TabBarView.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/16.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarView;

/**
 *  TabBarView的委托协议
 */
@protocol TabBarViewDelegate <NSObject>

/**
 *  TabBarView被选中的item
 *
 *  @param tabBarView 当前TabBarView对象
 *  @param index      被选中的item的index
 */
- (void)tabBarView:(TabBarView *)tabBarView didSelectAtIndex:(NSInteger)index;

//- (void)changeTabIcon:(NSInteger)index;

@end

/**
 *  App下导航栏
 */
@interface TabBarView : UIView

/**
 *  TabBarView对象
 */
@property (nonatomic, weak) id<TabBarViewDelegate> delegate;

//@property (nonatomic,assign) NSInteger index;

@end
