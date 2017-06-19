//
//  ViewController.m
//  Clock
//
//  Created by 田耀琦 on 2017/6/8.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "ViewController.h"

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

@interface ViewController ()

@property (nonatomic,strong)UIView *clockView;

@property (nonatomic,strong)CALayer *hourLayer;

@property (nonatomic,strong)CALayer *layerMin;

@property (nonatomic,strong)CALayer *layerSec;

@property (nonatomic,strong)CALayer *pointLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self creatUI];
    [self test];
}

- (void)test {
    ClockView *clock = [[ClockView alloc] initWithFrame:CGRectMake(100, 100, 108, 108)];
    clock.backgroundColor = [UIColor redColor];
    [self.view addSubview:clock];
}

#pragma mark - UI
- (void)creatUI {
    UIView *clockView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    clockView.layer.cornerRadius = 100;
    clockView.layer.borderWidth = 2;
    clockView.layer.borderColor = [UIColor redColor].CGColor;
    clockView.clipsToBounds = YES;
    self.clockView = clockView;
    [self.view addSubview:clockView];
    
    
    int x;
    int y;
    for (int i = 0; i < 12; i ++) {
        if ((M_PI / 6.0 * i > M_PI / 2.0 && M_PI / 6.0 * i < M_PI) ||( M_PI / 6.0 * i > M_PI /2.0 * 3 && M_PI /6.0 *i < M_PI * 2)) {
            x = 100 - 90 * cos(M_PI/6.0 * i);
            y = 100 + 90 * sin(M_PI/6.0 * i);
        }
        else {
            x = 100 + 90 * cos(M_PI/6.0 * i);
            y = 100 - 90 * sin(M_PI/6.0 * i);
        }
        UIView *point = [[UIView alloc] initWithFrame:CGRectMake(x, y, 2, 2)];
        point.backgroundColor = [UIColor blueColor];
        [clockView addSubview:point];
    }
    
    [clockView.layer addSublayer:self.hourLayer];
    [clockView.layer addSublayer:self.layerMin];
    [clockView.layer addSublayer:self.layerSec];
    [clockView.layer addSublayer:self.pointLayer];
    
    [self timeChange];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];

}

- (void)timeChange
{
    self.layerSec.transform = CATransform3DMakeRotation(CURRENTSEC * kPerSecondA, 0, 0, 1);
    self.layerMin.transform = CATransform3DMakeRotation(CURRENTMIN * kPerMinuteA, 0, 0, 1);
    
    self.hourLayer.transform = CATransform3DMakeRotation(CURRENTHOUR * kPerHourA, 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(CURRENTMIN * kPerHourMinuteA + CURRENTHOUR*kPerHourA, 0, 0, 1);
    

}

- (CALayer *)hourLayer {
    if (!_hourLayer) {
        _hourLayer = [[CALayer alloc] init];
        _hourLayer.bounds = CGRectMake(0, 0, 6, 40);
        _hourLayer.backgroundColor = [UIColor blackColor].CGColor;
        _hourLayer.cornerRadius = 5;
        _hourLayer.anchorPoint = CGPointMake(0.5,1);
        _hourLayer.position = CGPointMake(self.clockView.bounds.size.width / 2.0, self.clockView.bounds.size.height/2.0);
    }
    return _hourLayer;
}

- (CALayer *)layerSec
{
    if (_layerSec == nil) {
        _layerSec = [CALayer layer];
        _layerSec.bounds = CGRectMake(0, 0, 2, 80);
        _layerSec.backgroundColor = [UIColor redColor].CGColor;
        _layerSec.cornerRadius = 5;
        _layerSec.anchorPoint = CGPointMake(0.5, 1);
        _layerSec.position = CGPointMake(self.clockView.bounds.size.width/2, self.clockView.bounds.size.height/2);
    }
    return _layerSec;
}

- (CALayer *)layerMin
{
    if (_layerMin == nil) {
        _layerMin = [CALayer layer];
        _layerMin.bounds = CGRectMake(0, 0, 4, 60);
        _layerMin.backgroundColor = [UIColor blackColor].CGColor;
        _layerMin.cornerRadius = 5;
        _layerMin.anchorPoint = CGPointMake(0.5, 1);
        _layerMin.position = CGPointMake(self.clockView.bounds.size.width/2, self.clockView.bounds.size.height/2);
    }
    return _layerMin;
}

- (CALayer *)pointLayer {
    if (!_pointLayer) {
        _pointLayer = [[CALayer alloc] init];
        _pointLayer.bounds = CGRectMake(40, 40, 1, 1);
        _pointLayer.backgroundColor = [UIColor blueColor].CGColor;
        _pointLayer.anchorPoint = CGPointMake(0.5, 1);
    }
    return _pointLayer;
}

- (void)creatPointInClock {
    
}



@end
