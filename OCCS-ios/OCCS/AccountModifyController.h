//
//  AccountModifyController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PupupViewController.h"

@protocol PupupPresentViewDelegate;

@interface AccountModifyController :PupupViewController

@property (weak, nonatomic) IBOutlet UIButton *changePassBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeMobileBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeEmailBtn;

- (IBAction)changePass:(UIButton *)sender;
- (IBAction)changeMobile:(UIButton *)sender;
- (IBAction)changeEmail:(UIButton *)sender;

@end
