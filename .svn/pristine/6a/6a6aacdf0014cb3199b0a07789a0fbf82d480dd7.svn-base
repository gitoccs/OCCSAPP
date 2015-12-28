//
//  LDDatePickerController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/2.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "LDDatePickerController.h"

@interface LDDatePickerController ()

@end

@implementation LDDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeDate:(UIButton *)sender {
    [self.delegate dismissDatePickerWithData:self.datePicker.date context:self.view];
}

- (IBAction)cancelDate:(UIButton *)sender {
    [self.delegate dismissDatePickerCancel:self.view];
}
@end
