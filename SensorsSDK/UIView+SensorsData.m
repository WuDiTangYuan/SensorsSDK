//
//  UIView+SensorsData.m
//  SensorsSDK
//
//  Created by huixin.a.zhang on 2021/3/25.
//

#import "UIView+SensorsData.h"

@implementation UIView (SensorsData)

- (NSString *)sensorsdata_elementType{
    //返回当前控件的类型
    return NSStringFromClass([self class]);
}

- (NSString *)sensorsdata_elementContent{
    //如果是隐藏控件，不获取内容，直接返回
    if (self.isHidden || self.alpha == 0) {
        return nil;
    }
    //初始化一个可变数组用于保存控件的内容
    NSMutableArray *contents = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        //获取子控件的内容
        //如果子控件有内容，例如UILabel的text。获取到的就是text属性
        //如果子类没有内容，递归调用该方法，获取其子控件的内容
        NSString *content = view.sensorsdata_elementContent;
        if ([content length] > 0) {
            [contents addObject:content];
        }
    }
    //当未获取到子控件的内容时返回nil，如果获取到多个子控件的内容时，用 - 拼接起来
    return contents.count == 0 ? nil:[contents componentsJoinedByString:@"-"];
}

- (UIViewController *)sensorsdata_viewController{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
    }
    //如果没找到就返回nil
    return nil;
}
@end

@implementation UILabel (SensorsData)

- (NSString *)sensorsdata_elementContent{
    return self.text ?: super.sensorsdata_elementContent;
}
@end

@implementation UIButton (SensorsData)

- (NSString *)sensorsdata_elementContent{
    return self.currentTitle ?: super.sensorsdata_elementContent;
}
@end

@implementation UISwitch (SensorsData)

- (NSString *)sensorsdata_elementContent{
    //在此处定一个规则，如果UISwitch当前为打开状态，设置内容为checked，否则为unchecked
    return self.on ? @"checked" : @"unchecked";
}
@end

@implementation UISlider (SensorsData)

- (NSString *)sensorsdata_elementContent{
    //在此处定一个规则，取UISlider当前的值并保留两位小数作为文本
    return [NSString stringWithFormat:@"%.2f",self.value];
}
@end

@implementation UISegmentedControl (SensorsData)

- (NSString *)sensorsdata_elementContent{
    //在此处定一个规则，取UISegmentedControl当前选定的index作为文本
    return [self titleForSegmentAtIndex:self.selectedSegmentIndex];
}
@end

@implementation UIStepper (SensorsData)

- (NSString *)sensorsdata_elementContent{
    //在此处定一个规则，取UIStepper当前的值作为文本
    return [NSString stringWithFormat:@"%g",self.value];
}
@end
