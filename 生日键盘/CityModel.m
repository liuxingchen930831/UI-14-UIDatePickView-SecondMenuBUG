//
//  CityModel.m
//  生日键盘
//
//  Created by liuxingchen on 16/10/9.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
+(instancetype)cityWithDict:(NSDictionary *)dict
{
    CityModel *city =[[self alloc]init];
    [city setValuesForKeysWithDictionary:dict];
    return city;
}
@end
