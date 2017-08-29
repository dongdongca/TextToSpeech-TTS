//
//  TextToSpeechViewController.h
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/28.
//  Copyright © 2017年 李东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LanguageListModel;

@interface TextToSpeechViewController : UIViewController

@property (nonatomic, strong) LanguageListModel *model;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger row;
@end
