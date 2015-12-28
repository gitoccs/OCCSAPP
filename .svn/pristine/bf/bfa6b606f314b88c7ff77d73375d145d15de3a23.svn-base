//
//  ChangePassNewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "ChangePassNewController.h"
#import "AccountModifyController.h"
#import "GDataXMLNode.h"

@interface ChangePassNewController ()

@end

@implementation ChangePassNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置新密码";
    [self roundAllButtons];
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

- (IBAction)yesBtn:(UIButton *)sender {
    if ([self.passNew01.text isBlank]) {
        [Utilitys showAlertWithMsg:@"新密码不能为空" andTitle:@"提示" andVc:self];
        return;
    }
    
    if (![self.passNew01.text isEqualToString:self.passNew02.text]) {
        [Utilitys showAlertWithMsg:@"验证密码必须和新密码一致" andTitle:@"提示" andVc:self];
    }else if(![[self isValidPassWord] isEqualToString:@""]){
        [Utilitys showAlertWithMsg:[self isValidPassWord] andTitle:@"提示" andVc:self];
    }else{
        [LDNetwokAPI changePasswordByKeyword:KEYWORD userName:[Person getInstance].name passWord:self.passNew01.text
                                successBlock:^(id returnData) {
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
                                            AccountModifyController *popVC = (AccountModifyController *)self.navigationController.viewControllers[0];
                                            [popVC.delegate dismissSelfVC];
                                            Person *p = [Person getInstance];
                                            p.password = self.passNew01.text;
                                            [p saveInstance];
                                        }else{
                                            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
                                        }
                                    }
        } failureBlock:^(NSError *error) {
            [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        } showHUD:YES];
    }
}

///验证密码
- (NSString *) isValidPassWord
{
    NSString *msg = @"";
    NSString *pwdRegex = @"^.*(([a-z]|[A-Z])+.*[0-9]+)|([0-9]+.*([a-z]|[A-Z])+).*$";
    NSPredicate *pwdPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    if(![pwdPred evaluateWithObject:self.passNew01.text])
    {
        msg = @"密码必须包含字母和数字";
    }
    return msg;
}

@end
