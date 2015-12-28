//
//  ChangeMobileCodeController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "PupupViewController.h"

@interface ChangeMobileCodeController : PupupViewController
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

- (IBAction)goNext:(UIButton *)sender;
- (IBAction)getCode:(UIButton *)sender;

@end
