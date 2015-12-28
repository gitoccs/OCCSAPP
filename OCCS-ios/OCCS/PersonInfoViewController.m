//
//  PersonInfoViewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/10/30.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+extended.h"

@interface PersonInfoViewController ()

@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSArray *propAry;
@property (nonatomic, strong) NSArray *modifyAry;
@property (nonatomic, strong) Person *person;
@property (nonatomic) BOOL isCamera;
@property (nonatomic) BOOL editMode;
@property (nonatomic, copy) Person *tempPerson;
@property (nonatomic, strong) LDDatePickerController *datePicker;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person getInstance];
    self.tempPerson = self.person.copy;
    self.title = @"我的信息";
    if ([[Person getTypeFromInt] isEqualToString:@"个人"]) {
        self.titleAry = @[@"姓名",@"昵称",@"性别",@"证件号",@"生日",@"地址",@"毕业院校",@"手机号",@"邮箱",@"QQ",@"微信",@"推荐人"];
        self.propAry = @[@"realname",@"nickname",@"sex",@"idno",@"birthday",@"address",@"educollege",@"mobile",@"email",@"qq",@"weixin",@"tjid"];
        self.modifyAry = @[@"nickname",@"sex",@"birthday",@"address",@"educollege",@"qq",@"weixin"];
    }else{
        self.titleAry = @[@"企业名称", @"企业昵称", @"企业行业", @"公司地址", @"公司电话", @"公司网址", @"组织机构代码", @"公司简介"];
        self.propAry = @[@"realname",@"nickname",@"industry",@"address",@"mobile",@"url",@"orgcode",@"summary"];
        self.modifyAry = @[];
    }
    
    [self.navigationController.navigationBar setBackgroundColor:[Person getColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                         target:self action:@selector(disMissSelf:)];
    [self checkEditMode];
    
    [[self infoTable] registerNib:[UINib nibWithNibName:@"PersonCell" bundle:nil]
           forCellReuseIdentifier:@"PersonCell"];
    
    [[self infoTable] registerNib:[UINib nibWithNibName:@"PersonIconCell" bundle:nil]
           forCellReuseIdentifier:@"PersonIconCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)toggleEditMode:(UIBarButtonItem *)btn{
    self.editMode = !self.editMode;
    [self checkEditMode];
}

- (void)checkEditMode{
    if ([[Person getTypeFromInt] isEqualToString:@"个人"]) {
        if (!self.editMode) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                                   target:self action:@selector(toggleEditMode:)];
        }else{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                   target:self action:@selector(toggleEditMode:)];
        }
        [self.infoTable reloadData];
        if (!self.editMode) {
            [self savePersonData];
        }

    }
}

- (void)savePersonData
{
    if (![self.tempPerson isEqualToPerson:self.person keys:self.modifyAry]) {
        NSLog(@"save person");
        [Person setInstance:self.tempPerson];
        [LDNetwokAPI UploadUserInfoByKeyword:KEYWORD
                                         key:[Person getInstance].key
                                    jsonData:[Person personToJson]
                                  successBlock:^(id returnData) {
                                      NSLog(@"%@",returnData);
                                  } failureBlock:^(NSError *error) {
                                      [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                                  } showHUD:YES];
    }else{
        NSLog(@"person not change");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disMissSelf:(UIBarButtonItem *)btn{
    [self.view endEditing:YES];
    [self.delegate dismissSelfVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeImage" object:self.iconImage.image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goPhotoDetail:(UIButton *)sender {
//    CameraViewController *camVC = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
//    [self.navigationController pushViewController:camVC animated:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"打开相机",@"从相册导入",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UITableView Datasource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger index = indexPath.row;
    UITableViewCell *cell;
    if (index == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.iconImage = nil;
        self.iconImage = [cell.contentView viewWithTag:1];
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width/2;
        UILabel *nameLabel = [cell.contentView viewWithTag:2];
        UIButton *cameraBtn = [cell.contentView viewWithTag:3];
        nameLabel.text = _person.name;
        self.iconImage.image = self.orgImg;
        [cell.contentView setBackgroundColor:[Person getColor]];
        [cameraBtn addTarget:self action:@selector(goPhotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        titleLabel.text = self.titleAry[index-1];
        UITextField *textField = [cell.contentView viewWithTag:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        textField.text = [self.tempPerson valueForKey:self.propAry[index - 1]];
        textField.frame = CGRectMake(100, 0, 100, 44);
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (self.editMode && [self.modifyAry indexOfObject:self.propAry[index - 1]] <= self.modifyAry.count) {
            [cell setBackgroundColor:[UIColor colorWithRed:240/255.0 green:1.0 blue:1.0 alpha:1.0]];
            [textField setEnabled:YES];
            [textField setUserInteractionEnabled:YES];
            [textField setBorderStyle:UITextBorderStyleRoundedRect];
        }else{
            [cell setBackgroundColor:[UIColor colorWithRed:255/255.0 green:1.0 blue:1.0 alpha:1.0]];
            [textField setUserInteractionEnabled:NO];
            [textField setEnabled:NO];
            [textField setBorderStyle:UITextBorderStyleNone];
        }
    }
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField {
    [UIView animateWithDuration:0.1 animations: ^{
        [textField invalidateIntrinsicContentSize];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleAry.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 120 : 50;
}

#pragma mark -
#pragma mark UITextField delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"end editing");
    UILabel *titleLabel = [textField.superview viewWithTag:1];
    long index = [self.titleAry indexOfObject:titleLabel.text];
    [self.tempPerson setValue:textField.text forKey:self.propAry[index]];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"begin editing");
    UILabel *titleLabel = [textField.superview viewWithTag:1];
    if ([titleLabel.text isEqualToString:@"性别"]) {
        [self.view endEditing:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择性别"
                                                       delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
        [alert show];
        return NO;
    }
    
    if ([titleLabel.text isEqualToString:@"生日"]) {
        [self.view endEditing:YES];
        self.datePicker = [[LDDatePickerController alloc] initWithNibName:@"LDDatePickerController" bundle:nil];
        self.datePicker.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.datePicker.delegate = self;
        [self.view addSubview:self.datePicker.view];
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark LDDatePicker methods

- (void)dismissDatePickerWithData:(NSDate *)date context:(UIView *)view {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    self.tempPerson.birthday = dateStr;
    [self.infoTable reloadData];
    [view removeFromSuperview];
}

- (void)dismissDatePickerCancel:(UIView *)view {
    [view removeFromSuperview];
}

#pragma mark -
#pragma mark UIAlertView delegate methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            self.tempPerson.sex = @"男";
            [self.infoTable reloadData];
            break;
        case 2:
            self.tempPerson.sex = @"女";
            [self.infoTable reloadData];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UIActionSheet delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
                imagePicker.allowsEditing = YES;
                self.isCamera = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            
        }
            break;
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
                imagePicker.allowsEditing = YES;
                self.isCamera = NO;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
            break;
        case 2:
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UIImagePickerController methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(170.0, 170.0)];
        NSLog(@"%f",image.size.width);
        self.iconImage.image = image;
        NSString *baseImg = [image base64String];
        NSString *outString = [baseImg stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        NSString *imgName = [NSString stringWithFormat:@"%@%@.jpg",[Person getInstance].name,[Person getInstance].mobile];
        
        [LDNetwokAPI UploadUserAvatarByKeyword:KEYWORD
                                      userName:[Person getInstance].name
                                       imgInfo:outString
                                       imgName:imgName
                                  successBlock:^(id returnData) {
            
        } failureBlock:^(NSError *error) {
            [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        } showHUD:YES];

        if (!self.isCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            // code here to support video
        }else{
            
        }
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save failed"
                                                        message:@"Failed to save image"
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
