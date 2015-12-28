//
//  LDLabel.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    LineTypeNone,//没有画线
    LineTypeUp ,// 上边画线
    LineTypeMiddle,//中间画线
    LineTypeDown,//下边画线
    
} LineType ;


@interface LDLabel : UILabel
{
    SEL        _action;
    id         _target;
}

@property (assign, nonatomic) LineType lineType;
@property (assign, nonatomic) UIColor * lineColor;

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents;



@end
