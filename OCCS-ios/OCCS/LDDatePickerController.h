//
//  LDDatePickerController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/2.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LDDatePickDelegate;

@interface LDDatePickerController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id<LDDatePickDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

- (IBAction)changeDate:(UIButton *)sender;
- (IBAction)cancelDate:(UIButton *)sender;

@end

@protocol LDDatePickDelegate <NSObject>

- (void)dismissDatePickerWithData:(NSDate *)date context:(UIView *)view;
- (void)dismissDatePickerCancel:(UIView *)view;

@end
