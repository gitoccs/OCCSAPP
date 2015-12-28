//
//  ChangePassOldController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "ChangePassOldController.h"
#import "ChangePassNewController.h"
#import "GDataXMLNode.h"

@interface ChangePassOldController ()

@end

@implementation ChangePassOldController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入旧密码";
    [self roundAllButtons];
    self.nameLabel.text = [Person getInstance].name;
    [self backTapHideKeyboard];
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

- (IBAction)nextBtn:(UIButton *)sender {
    if (![self.passTextField.text isBlank]) {
        [LDNetwokAPI checkPasswordByKeyword:KEYWORD password:self.passTextField.text username:[Person getInstance].name
                               successBlock:^(id returnData){
                                   NSString *status;
                                   NSString *msg;
                                   if (returnData != nil)
                                   {
                                       GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                                       NSArray *results = [doc nodesForXPath:@"//results" error:nil];
                                       // 循环遍历每一个<results.../>元素
                                       for(GDataXMLElement *resultElement in results)
                                       {
                                           //获取需求名称元素
                                           status = [[[resultElement elementsForName:@"status"] objectAtIndex:0] stringValue];
                                           msg = [[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue];
                                       }
                                       if ([status intValue] == 1) {
                                           ChangePassNewController *passNewVC = [[ChangePassNewController alloc] initWithNibName:@"ChangePassNewController" bundle:nil];
                                           [self.navigationController pushViewController:passNewVC animated:YES];
                                       }else{
                                           [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
                                       }
                                   }
                               }failureBlock:^(NSError *error) {
                                   [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                               } showHUD:YES];
    }else{
        [Utilitys showAlertWithMsg:@"密码不能为空" andTitle:@"提示" andVc:self];
    }
}

@end
