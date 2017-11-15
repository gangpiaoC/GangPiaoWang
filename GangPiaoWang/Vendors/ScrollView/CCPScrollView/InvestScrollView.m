//
//  InvestScrollView.m
//  AMT
//
//  Created by aimutou on 17/3/10.
//  Copyright © 2017年 aimutou. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#import "InvestScrollView.h"
#import "XHColor.h"
#import "RTLabel.h"
@interface InvestScrollView ()<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic,strong) UIScrollView *ccpScrollView;
/**
 *  label的宽度
 */
@property (nonatomic,assign) CGFloat labelW;
/**
 *  label的高度
 */
@property (nonatomic,assign) CGFloat labelH;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  记录滚动的页码
 */
@property (nonatomic,assign) int page;


@end

@implementation InvestScrollView

- (UIScrollView *)ccpScrollView {
    
    if (_ccpScrollView == nil) {
        _ccpScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _ccpScrollView.showsHorizontalScrollIndicator = NO;
        _ccpScrollView.showsVerticalScrollIndicator = NO;
        _ccpScrollView.scrollEnabled = NO;
        _ccpScrollView.pagingEnabled = false;
        [self addSubview:_ccpScrollView];
        
        [_ccpScrollView setContentOffset:CGPointMake(0 ,0) animated:YES];
    }
    
    return _ccpScrollView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.labelW = frame.size.width;
        
        self.labelH = 24;
        
        self.ccpScrollView.delegate = self;
        
        [self addTimer];
        
    }
    
    return self;
}

//重写set方法 创建对应的investArray
- (void)setInvestArray:(NSArray *)investArray {
    

    
    if (investArray == nil) {
        [self removeTimer];
        return;
    }
    
    if (investArray.count == 1) {
        [self removeTimer];
    }
    
    
     _investArray = investArray;
    
    //CGFloat contentW = 0;
    CGFloat contentH =self.labelH *_investArray.count;
    
    self.ccpScrollView.contentSize = CGSizeMake(0, contentH);
    
//    CGFloat labelW = self.ccpScrollView.frame.size.width;
    self.labelW = self.bounds.size.width;
//    CGFloat labelH = self.ccpScrollView.frame.size.height;
//    CGFloat labelX = 0;
    
    [self.ccpScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];

    
    //CGFloat fontNum = SCREEN_WIDTH == 320 ? 13:14;
    
    
    for (int i = 0; i < investArray.count; i++) {
        
        NSString *tempStr  = investArray[i];
        RTLabel *projectLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, self.labelH*i, self.labelW, self.labelH)];
        projectLabel.text = tempStr;
        [self.ccpScrollView addSubview:projectLabel];
        
//        if (i !=objArray.count-1) {
//            //根据需求添加线条
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 43*(i+1)-0.5, SCREEN_WIDTH-26, 0.5)];
//            line.backgroundColor = [AMTColor colorWithHexString:@"e5e5e5"];
//            [self.ccpScrollView addSubview:line];
//        }
    }
    
}

- (void)clickTheLabel:(UITapGestureRecognizer *)tap {
    
    if (self.clickLabelBlock) {
        
        NSInteger tag = tap.view.tag - 1;
        
        if (tag < 100) {
            
            tag = 100 + (self.investArray.count - 1);
            
        }
        
        self.clickLabelBlock(tag - 100,self.investArray[tag - 100]);
        
    }
    
}

- (void) clickTitleLabel:(clickLabelBlock) clickLabelBlock {
    
    self.clickLabelBlock = clickLabelBlock;
    
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    
    if (isCanScroll) {
        
        self.ccpScrollView.scrollEnabled = YES;
        
    } else {
        
        self.ccpScrollView.scrollEnabled = NO;
        
    }
    
}

- (void)nextLabel {
    _page = _page +1;
    CGPoint oldPoint = self.ccpScrollView.contentOffset;
    oldPoint.y = _page;
    [self.ccpScrollView setContentOffset:oldPoint animated:YES];
    
}
//当滚动时调用scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.ccpScrollView.contentOffset.y >= self.labelH*(self.investArray.count - self.bounds.size.height / self.labelH) &&(int)self.ccpScrollView.contentOffset.y % (int)self.labelH == 0) {  //循环滚动节点判断，可能不准确
        _page = 0;
        [self.ccpScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
}


// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

- (void)addTimer{
    
    /*
     scheduledTimerWithTimeInterval:  滑动视图的时候timer会停止
     这个方法会默认把Timer以NSDefaultRunLoopMode添加到主Runloop上，而当你滑tableView的时候，就不是NSDefaultRunLoopMode了，这样，你的timer就会停了。
     self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
     */
    
    self.timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
}


@end
