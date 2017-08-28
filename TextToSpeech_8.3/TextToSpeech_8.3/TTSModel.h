//
//  TTSModel.h
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/28.
//  Copyright © 2017年 李东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSModel : NSObject

@property (nonatomic, copy) NSString *LS;

@property (nonatomic, copy) NSString *EG;

- (instancetype)initWithDict:(NSDictionary *) dict;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
