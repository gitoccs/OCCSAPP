//
//  LDRegisterViewController.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDRegisterViewController : LDBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UITextField *userTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UITextField *affirmTf;
@property (weak, nonatomic) IBOutlet UITextField *referrerIDTf;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *navititle;
@property (weak, nonatomic) IBOutlet LDLabel *xieyiLabel;

///用户组
@property (nonatomic ,assign) NSInteger userGroupID;

@end
