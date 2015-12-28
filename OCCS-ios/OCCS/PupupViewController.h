//
//  PupupViewController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PupupPresentViewDelegate;

@interface PupupViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) id<PupupPresentViewDelegate>delegate;

- (void)initNavBarItemsWithTitle:(NSString *)title;
- (void)disMissSelf:(UIBarButtonItem *)btn ;
- (void)roundAllButtons;
- (void)backTapHideKeyboard;
- (void)backTapped:(UITapGestureRecognizer *)gesture;

@end

@protocol PupupPresentViewDelegate <NSObject>

- (void) dismissSelfVC;

@end
