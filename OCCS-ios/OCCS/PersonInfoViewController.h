//
//  PersonInfoViewController.h
//  OCCS
//
//  Created by 烨 刘 on 15/10/30.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDatePickerController.h"
#import "SysNoteProtocol.h"

@protocol PersonInfoDelegate;

@interface PersonInfoViewController : UIViewController<UITableViewDataSource, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, LDDatePickDelegate>
@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UIImageView *iconImage;
@property (weak, nonatomic) UIImage *orgImg;

@property (nonatomic, weak) id<NotificationDelegate> delegate;

- (void)goPhotoDetail:(UIButton *)sender;

@end