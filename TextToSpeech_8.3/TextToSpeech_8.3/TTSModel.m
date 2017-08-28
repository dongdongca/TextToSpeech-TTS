//
//  TTSModel.m
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/28.
//  Copyright © 2017年 李东. All rights reserved.
//

#import "TTSModel.h"

@implementation TTSModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
