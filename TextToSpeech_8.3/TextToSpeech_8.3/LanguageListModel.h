//
//  LanguageListModel.h
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/29.
//  Copyright © 2017年 李东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageListModel : NSObject
//是否支持语音合成
@property (nonatomic, assign) NSNumber *languageIsSupportSpeech;
//语言及其国家
@property (nonatomic, copy) NSString *languagesOrCountry;
//谷歌语音识别code
@property (nonatomic, copy) NSString *googleLanguageCode;
//手机语言code
@property (nonatomic, copy) NSString *iPhoneLanguageCode;
//手机地区Identifier
@property (nonatomic, copy) NSString *iPhoneLocaleIdentifier;
//语言及其国家（中文，便于区分）
@property (nonatomic, copy) NSString *languagesOrCountryCN;
//谷歌翻译的Code googleTranslationCode
@property (nonatomic, copy) NSString *googleTranslationCode;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)languageListModelWithDict:(NSDictionary *)dict;

@end
