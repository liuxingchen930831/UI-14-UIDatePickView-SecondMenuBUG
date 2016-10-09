//
//  CityModel.h
//  生日键盘
//
//  Created by liuxingchen on 16/10/9.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
/** 省 */
@property(nonatomic,copy)NSString * name ;
/** 市 */
@property(nonatomic,copy)NSArray * cities ;
+(instancetype)cityWithDict:(NSDictionary *)dict;
@end
