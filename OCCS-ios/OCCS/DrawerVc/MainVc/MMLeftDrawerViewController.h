//
//  MMLeftDrawerViewController.h
//  MusicKingdom
//
//  Created by Gennie Sun on 14-9-12.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PupupViewController.h"
#import "LDWebViewController.h"
#import "SysNoteProtocol.h"

@interface MMLeftDrawerViewController :WebUIViewController <PupupPresentViewDelegate, NotificationDelegate>

@property (nonatomic, strong) UIButton *photoBtn;

@end
