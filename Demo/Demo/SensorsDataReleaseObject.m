//
//  SensorsDataReleaseObject.m
//  Demo
//
//  Created by 张慧鑫 on 2021/4/18.
//

#import "SensorsDataReleaseObject.h"

@implementation SensorsDataReleaseObject

- (void)signalCrash{
    NSMutableArray<NSString*> *array = [[NSMutableArray alloc]init];
    [array addObject:@"test"];
    [array release];
    //这里会崩溃，因为array已经被释放了
    NSLog(@"%@",array.firstObject);
}
@end
