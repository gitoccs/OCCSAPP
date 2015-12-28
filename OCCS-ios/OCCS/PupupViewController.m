//
//  PupupViewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "PupupViewController.h"

@interface PupupViewController ()

@end

@implementation PupupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNavBarItemsWithTitle:(NSString *)title{
    self.title = title;
    [self.navigationController.navigationBar setBackgroundColor:[Person getColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self action:@selector(disMissSelf:)];
}

- (void)backTapHideKeyboard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)backTapped:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

- (void)roundAllButtons
{
    for (UIButton *btn in [self.view subviews]) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
    }
}

- (void)disMissSelf:(UIBarButtonItem *)btn {
    [self.delegate dismissSelfVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
