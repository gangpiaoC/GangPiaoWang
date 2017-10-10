//
//  UILabel+YXYNumberAnimationLabel.h
//  YXYNumberAnimationLabelDemo
//
//  Created by 杨萧玉 on 14-5-25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UILabel (YXYNumberAnimationLabel)
@property (nonatomic, assign) CGFloat toNumber;
-(void)changeFromNumber:(double) originalnumber toNumber:(double) newnumber withAnimationTime:(NSTimeInterval)timeSpan;
-(void)changNumToNumber:(double)number withDurTime:(double)time;
-(double)animationSpeed;
-(void)setAnimationSpeed:(double)speed;
@end
