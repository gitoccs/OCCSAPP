//
//  ChangeMobileDoController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "PupupViewController.h"

@interface ChangeMobileDoController : PupupViewController
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
- (IBAction)goCode:(UIButton *)sender;
- (IBAction)goMobile:(UIButton *)sender;

@end
