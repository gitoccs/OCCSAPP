//
//  OccsGongdanControllerViewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/11.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "OccsGongdanController.h"

@interface OccsGongdanController ()

@end

@implementation OccsGongdanController

- (instancetype)initWithFrame:(CGRect)frame
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                        DEF_PAGE_GD,
                        [Person getInstance].name,
                        [Person getInstance].key,
                        [Person getInstance].mobile,
                        [Person getInstance].typeNumber,
                        [Person getInstance].email];
    if (self = [super initWithFrame:frame url:urlStr title:@"适合我的工单"]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
