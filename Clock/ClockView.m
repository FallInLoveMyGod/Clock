//
//  ClockView.m
//  Clock
//
//  Created by 田耀琦 on 2017/6/12.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "ClockView.h"

//获得当前的年月日 时分秒
#define  CURRENTSEC [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]
#define  CURRENTMIN [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
#define  CURRENTHOUR [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
#define  CURRENTDAY  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
#define  CURRENTMONTH [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
#define  CURRENTYEAR [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]

//角度转换成弧度
#define  ANGEL(x) x/180.0 * M_PI

#define kPerSecondA     ANGEL(6)
#define kPerMinuteA     ANGEL(6)
#define kPerHourA       ANGEL(30)
#define kPerHourMinuteA ANGEL(0.5)

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - UI 

- (void)initView {
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
    self.clipsToBounds = YES;
    
    [self creatScale];
    
    [self timerAction:nil];
    [self.layer addSublayer:self.hourLayer];
    [self.layer addSublayer:self.miniteLayer];
    [self.layer addSublayer:self.secendLayer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [timer fire];
}

//  创建刻度
- (void)creatScale {
    int x;
    int y;
    int radius = self.frame.size.width / 2.0;
    for (int i = 0; i < 12; i ++) {
        if ((M_PI / 6.0 * i > M_PI / 2.0 && M_PI / 6.0 * i < M_PI) ||( M_PI / 6.0 * i > M_PI /2.0 * 3 && M_PI /6.0 *i < M_PI * 2)) {
            x = radius - (radius - 10) * cos(M_PI/6.0 * i);
            y = radius + (radius - 10) * sin(M_PI/6.0 * i);
        }
        else {
            x = radius + (radius - 10) * cos(M_PI/6.0 * i);
            y = radius - (radius - 10) * sin(M_PI/6.0 * i);
        }
        UIView *point = [[UIView alloc] initWithFrame:CGRectMake(x, y, 2, 2)];
        point.layer.cornerRadius = 1;
        point.clipsToBounds = YES;
        point.backgroundColor = [UIColor whiteColor];
        [self addSubview:point];
    }
    
    UIView *centerPoint = [[UIView alloc] initWithFrame:CGRectMake(radius - 2.5, radius - 2.5, 5, 5)];
    centerPoint.backgroundColor = [UIColor whiteColor];
    centerPoint.layer.cornerRadius = 2.0;
    centerPoint.clipsToBounds = YES;
    [self addSubview:centerPoint];
}

- (CALayer *)hourLayer {
    if (!_hourLayer) {
        _hourLayer = [CALayer layer];
        _hourLayer.bounds = CGRectMake(0, 0, 2, self.frame.size.width / 2.0 - 25);
        _hourLayer.cornerRadius = 5;
        _hourLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        _hourLayer.anchorPoint = CGPointMake(0.5, 1);
        _hourLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _hourLayer;
}

- (CALayer *)miniteLayer {
    if (!_miniteLayer) {
        _miniteLayer = [CALayer layer];
        _miniteLayer.bounds = CGRectMake(0, 0, 2, self.frame.size.width / 2.0 - 20);
        _miniteLayer.cornerRadius = 5;
        _miniteLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        _miniteLayer.anchorPoint = CGPointMake(0.5, 1);
        _miniteLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _miniteLayer;
}

- (CALayer *)secendLayer {
    if (!_secendLayer) {
        _secendLayer = [CALayer layer];
        _secendLayer.bounds = CGRectMake(0, 0, 2, self.frame.size.width / 2.0 - 15);
        _secendLayer.cornerRadius = 5;
        _secendLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        _secendLayer.anchorPoint = CGPointMake(0.5, 1);
        _secendLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _secendLayer;
}

#pragma mark - Action
- (void)timerAction:(id)timer {
    self.secendLayer.transform = CATransform3DMakeRotation(kPerSecondA * CURRENTSEC, 0, 0, 1);
    self.miniteLayer.transform = CATransform3DMakeRotation(kPerMinuteA * CURRENTMIN, 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(kPerHourA * CURRENTHOUR, 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(kPerHourA * CURRENTHOUR + kPerHourMinuteA * CURRENTMIN, 0, 0, 1);
}
@end
