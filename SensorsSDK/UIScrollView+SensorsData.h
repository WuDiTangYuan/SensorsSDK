//
//  UIScrollView+SensorsData.h
//  SensorsSDK
//
//  Created by 张慧鑫 on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "SensorsAnalyticsDelegateProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SensorsData)

@property(nonatomic,strong)SensorsAnalyticsDelegateProxy *sensorsdata_delegateProxy;

@end

NS_ASSUME_NONNULL_END
