//
//  ChangePassOldController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PupupViewController.h"

@interface ChangePassOldController : PupupViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
- (IBAction)nextBtn:(UIButton *)sender;

@end
