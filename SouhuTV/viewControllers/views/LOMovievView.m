//
//  LOMovievView.m
//  VideoTest
//
//  Created by 肖野 on 15/6/9.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "LOMovievView.h"
#define ContentViewHeight 40
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface LOMovievView ()
{
    MPMoviePlayerViewController *_moviePlayerViewController;
    MPMoviePlayerController *_moviePlayer;
    //播放进度label
    UILabel *_timeLabel;
    //
    NSTimer *_time;
    //播放进度条
    UISlider *_slider;
    //当前进度
    CGFloat _currentValue;
    
    //控制面板
    UIView *_contentView;
    //播放按钮
    UIButton *_startBtn;
    //全屏按钮
    UIButton *_fullBtn;
    //隐藏控制面板定时器
    NSTimer *_hiddenTime;
    
    NSUInteger _i;
}
//是否全屏状态
@property (nonatomic, assign) BOOL isFullScreen;
//视频是否播放
@property (nonatomic, assign, getter=isRun) BOOL run;
//是否为手动控制播放进度
@property (nonatomic, assign) BOOL changeTimeByHand;
//记录初始化的frame
@property (nonatomic) CGRect beforeFrame;
@end

@implementation LOMovievView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame andMovieURLStr:(NSString *)urlString
{
    _beforeFrame = frame;
    _run = YES;
    _i = 0;
    
    self = [super initWithFrame:frame];
    if (self) {
        _url = urlString;
//* * * * * * * * * * * * * * *    视频视图     * * * * * * * * * * * * * * * //
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:_url]];
                    //去掉系统自带的视图
        _moviePlayer = player.moviePlayer;
        _moviePlayer.controlStyle = MPMovieControlStyleNone;
        player.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - ContentViewHeight);
        [self addSubview:player.view];
        
//* * * * * * * * * * * * * * *    控制面板      * * * * * * * * * * * * * * * //
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, player.view.frame.size.height, frame.size.width, 40)];
        _contentView.backgroundColor = [UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:1];

    
//* * * * * * * * * * * * * * *    开始按钮      * * * * * * * * * * * * * * * //
        _startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _startBtn.frame = CGRectMake(0, 0, 40, 40);
        _startBtn.tag = 500;
        [_startBtn setImage:[UIImage imageNamed:@"PlayerFullScreen-Btn-Pause-Disable"] forState:UIControlStateNormal];

        [_startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [_startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_startBtn];
        
//* * * * * * * * * * * * * * *    全屏按钮      * * * * * * * * * * * * * * * //
        _fullBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _fullBtn.frame = CGRectMake(frame.size.width - 40, 0, 40, 40);
        _fullBtn.tag = 501;
        [_fullBtn setImage:[UIImage imageNamed:@"fullscreen_highlight"] forState:UIControlStateNormal];
        [_fullBtn addTarget:self action:@selector(fullAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_fullBtn];
        
//* * * * * * * * * * * * * * *    Slider      * * * * * * * * * * * * * * * //
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(45, 10, frame.size.width - 90, 20)];
        _slider.maximumValue = 100;
        _slider.minimumValue = 0;
        [_slider addTarget:self action:@selector(changeTimer:) forControlEvents:UIControlEventValueChanged];
        [_contentView addSubview:_slider];
        
        
//* * * * * * * * * * * * * * *    时间显示     * * * * * * * * * * * * * * * //
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 145, 20, 100, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        [_contentView addSubview:_timeLabel];
    
        
        _currentValue = _slider.value / 100;
        
        _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeLabel) userInfo:nil repeats:YES];
        
        [self addSubview:_contentView];
    }
    return self;
}
-(void)setUrl:(NSString *)url
{
    _url = url;
    _moviePlayer.contentURL =[NSURL URLWithString:url];
}

#pragma mark 时间显示Label
-(void)changeTimeLabel
{
    _i ++;
    
    NSMutableArray *s_array = [[NSMutableArray alloc] init];
    
    NSUInteger s_m ;
    
    NSUInteger s_s ;
    
    if (_changeTimeByHand == NO) {
        
        s_m = _i / 60;
        
        s_s = _i % 60;
        
        _slider.value = _moviePlayer.playableDuration / _moviePlayer.duration * 100;
        
    }else
        
    {
        s_m = _moviePlayer.duration * _currentValue / 60;
        
        s_s = _moviePlayer.duration * _currentValue - s_m * 60;
        
        _changeTimeByHand = NO;
        
    }
    
    [s_array addObject:[NSString stringWithFormat:@"%lu", (unsigned long)s_m]];
    
    [s_array addObject:[NSString stringWithFormat:@"%lu", (unsigned long)s_s]];
    

    NSMutableArray *a_array = [[NSMutableArray alloc] init];
    
    NSUInteger a_m = _moviePlayer.duration  / 60;
    
    NSUInteger a_s = _moviePlayer.duration - a_m * 60 ;
    
    
    [a_array addObject:[NSString stringWithFormat:@"%lu", (unsigned long)a_m]];
    
    [a_array addObject:[NSString stringWithFormat:@"%lu", (unsigned long)a_s]];
    
    
    
    for (int i = 0; i < s_array.count; i++) {
        
        if (((NSString *)s_array[i]).length < 2) {
            
            s_array[i] = [NSString stringWithFormat:@"0%@",s_array[i]];
            
        }
        
    }
    
    for (int i = 0; i < a_array.count; i++) {
        
        if (((NSString *)a_array[i]).length < 2) {
            
            a_array[i] = [NSString stringWithFormat:@"0%@",a_array[i]];
            
        }
        
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%@:%@/%@:%@",s_array[0],s_array[1], a_array[0], a_array[1]];
    
    if (_moviePlayer.playableDuration == _moviePlayer.duration) {
        [_time invalidate];
    }
}

#pragma mark 手动控制播放进度
-(void)changeTimer:(UISlider *)slider
{
    _currentValue = slider.value / 100;

    _changeTimeByHand = YES;
    //设置播放时间点
    [_moviePlayer setCurrentPlaybackTime:_moviePlayer.duration * _currentValue];
    
    [self changeTimeLabel];
}

#pragma mark 点击播放
-(void)startAction:(UIButton *)button
{
    if (self.isRun == YES) {
       [_moviePlayer pause];
        [button setImage:[UIImage imageNamed:@"PlayerInline-Btn-Play-Disable"] forState:UIControlStateNormal];
       self.run = NO;
    }else
    {
       [_moviePlayer play];
        [button setImage:[UIImage imageNamed:@"PlayerFullScreen-Btn-Pause-Disable"] forState:UIControlStateNormal];
       self.run = YES;
    }
    
}
#pragma mark 全屏显示
-(void)fullAction:(UIButton *)button
{
    if (_isFullScreen == YES) {
        
    }else
    {
        [button addTarget:self action:@selector(changeSmallScreen:) forControlEvents:UIControlEventTouchUpInside];

        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationLandscapeRight;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
    _isFullScreen = YES;
}

#pragma mark 恢复竖屏
-(void)changeSmallScreen:(UIButton *)button
{
    _isFullScreen = NO;
    
   [UIView animateWithDuration:0.5 animations:^{
       
       if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
           [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                          withObject:(id)UIInterfaceOrientationPortrait];
       }
   }];
    [button addTarget:self action:@selector(fullAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if ([[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"竖屏");
        
        [self setVerticalFrame];
        [[self viewWithTag:502] removeFromSuperview];
        [_hiddenTime invalidate];
        _hiddenTime = nil;
        _contentView.hidden = NO;
    }else if([[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight)
    
    {
        NSLog(@"横屏");
        
        [self setHorizontalFrame];
        _hiddenTime = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hiddenContentView) userInfo:nil repeats:YES];
    }
}

#pragma 隐藏控制面板
-(void)hiddenContentView
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 30)];
    btn.tag = 502;
    [btn addTarget:self action:@selector(appearContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    _contentView.hidden = YES;
    
}

#pragma mark 显示控制面板
-(void)appearContentView:(UIButton *)btn
{
    _contentView.hidden = NO;
}

#pragma mark 竖屏布局
-(void)setVerticalFrame
{
    
    self.frame = CGRectMake(_beforeFrame.origin.x, _beforeFrame.origin.y, _beforeFrame.size.width, _beforeFrame.size.height);
    
    _moviePlayer.view.frame = CGRectMake(0, 0, _beforeFrame.size.width, _beforeFrame.size.height - ContentViewHeight);
    _contentView.frame = CGRectMake(0, _beforeFrame.size.height - ContentViewHeight, _beforeFrame.size.width, ContentViewHeight);
    
    _startBtn.frame = CGRectMake(0, 0, 40, 40);
    _fullBtn.frame = CGRectMake(_beforeFrame.size.width - 40, 0, 40, 40);
    _slider.frame = CGRectMake(45, 10, _beforeFrame.size.width - 90, 20);
    _timeLabel.frame = CGRectMake(_beforeFrame.size.width - 145, 20, 100, 20);

}

#pragma mark 横屏布局
-(void)setHorizontalFrame
{
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    _moviePlayer.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    _contentView.frame = CGRectMake(0, ScreenHeight - 30, ScreenWidth, 30);
    
    _startBtn.frame = CGRectMake(0, 0, 30, 30);
    
    _fullBtn.frame = CGRectMake(ScreenWidth - 30, 0, 30, 30);
    
    _slider.frame = CGRectMake(35, 5, ScreenWidth - 70, 20);
    
    _timeLabel.frame = CGRectMake(ScreenWidth - 135, 12, 100, 20);
 
}


//MPMoviePlayerContentPreloadDidFinishNotification
//当电影播放器结束对内容的预加载后发出。因为内容可以在仅加载了一部分的情况下播放，所以这个通知可能在已经播放后才发出。
//MPMoviePlayerScallingModeDidChangedNotification
//当用户改变了电影的缩放模式后发出。用户可以点触缩放图标，在全屏播放和窗口播放之间切换。
//MPMoviePlayerPlaybackDidFinishNotification
//当电影播放完毕或者用户按下了Done按钮后发出。

@end
