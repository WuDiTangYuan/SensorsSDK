//
//  UITapGestureRecognizer+SensorsData.m
//  SensorsSDK
//
//  Created by 张慧鑫 on 2021/4/8.
//

#import "UIGestureRecognizer+SensorsData.h"
#import "NSObject+SASwizzler.h"
#import "SensorsAnalyticsSDK.h"

@implementation UIGestureRecognizer (SensorsData)

+(void)load{
    //交换 initWithTarget:action: 方法
    [UIGestureRecognizer sensorsdata_swizzleMethod:@selector(initWithTarget:action:) withMethod:@selector(sensorsadata_initWithTarget:action:)];
    //交换 addTarget:action: 方法
    [UIGestureRecognizer sensorsdata_swizzleMethod:@selector(addTarget:action:) withMethod:@selector(sensorsdata_addTarget:action:)];
}

-(instancetype)sensorsadata_initWithTarget:(id)target action:(SEL)action{
    //调用原始的初始化方法进行对象初始化
    [self sensorsadata_initWithTarget:target action:action];
    //调用添加Target_Action的方法，添加埋点的Target_Action
    //这里其实调用的是 sensorsdata_addTarget:action: 方法，因为已经进行过方法交换了
    [self addTarget:target action:action];
    return  self;
}

-(void)sensorsdata_addTarget:(id)target action:(SEL)action{
    //调用原始的方法，添加Target_Action
    [self sensorsdata_addTarget:target action:action];
    //新增Target_Action，用于触发$AppClick事件
    [self sensorsdata_addTarget:self action:@selector(sensorsdata_trackTapGestureAction:)];
}

-(void)sensorsdata_trackTapGestureAction:(UIGestureRecognizer*)sender{
    //设置只有状态是 UIGestureRecognizerStateEnded 时才触发埋点事件
    if (sender.state != UIGestureRecognizerStateEnded) {
        return;
    }
    //获取手势识别器的控件
    UIView *view = sender.view;
    //这里暂定只采集UILabel和UIImageView
    BOOL isTrackClass = [view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]];
    if (!isTrackClass) {
        return;
    }
    //触发$ApppClick事件
    [[SensorsAnalyticsSDK sharedInstance] trackAppClickWithView:view properties:nil];
}
@end
