//
//  TextToSpeechViewController.m
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/28.
//  Copyright © 2017年 李东. All rights reserved.
//

#import "TextToSpeechViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LanguageListModel.h"

@interface TextToSpeechViewController () <AVSpeechSynthesizerDelegate>

//输的内容
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
//当前语言的简写
@property (weak, nonatomic) IBOutlet UILabel *currentLG;
//开始按钮
@property (weak, nonatomic) IBOutlet UIButton *startButton;
//暂停
@property (weak, nonatomic) IBOutlet UIButton *suspendedButton;
//继续
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
//停止
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
//语调
@property (weak, nonatomic) IBOutlet UILabel *pitchMultiplierValue;
//语调值
@property (weak, nonatomic) IBOutlet UISlider *pitchMultiplierSlider;
//音量
@property (weak, nonatomic) IBOutlet UILabel *volumeValue;
//音量值
@property (weak, nonatomic) IBOutlet UISlider *volumeValueSlider;
//语速
@property (weak, nonatomic) IBOutlet UISlider *rateSlider;
@property (weak, nonatomic) IBOutlet UILabel *rateValue;
//国家以及语言
@property (weak, nonatomic) IBOutlet UILabel *languageOrCountry;
//手机语言Code，可空
@property (weak, nonatomic) IBOutlet UILabel *iPhoneLanguageCode;
//谷歌翻译Code
@property (weak, nonatomic) IBOutlet UILabel *googleTranslationCode;




//合成器
@property (nonatomic, strong) AVSpeechSynthesizer * avSS;



@end

@implementation TextToSpeechViewController

#pragma mark - 懒加载
- (AVSpeechSynthesizer *)avSS {
    if (!_avSS) {
        _avSS = [[AVSpeechSynthesizer alloc] init];
        _avSS.delegate = self;
    }
    return _avSS;
}

- (void)setModel:(LanguageListModel *)model {
    _model = model;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClickAction)];
    
    [self setupProperties:self.dataSource[self.row]];
    
}

- (void)rightBarButtonClickAction {
    self.row++;
    if (self.row <= self.dataSource.count - 1) {
        [self setupProperties:self.dataSource[self.row]];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示框"message:@"没有啦还要点啊————————" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:true completion:nil];
        return;
        
    }
}

- (void)setupProperties:(LanguageListModel *)currentMdoel {
    self.contentTextField.text = currentMdoel.languagesOrCountry;
    self.currentLG.text = currentMdoel.googleLanguageCode;
    self.languageOrCountry.text = currentMdoel.languagesOrCountryCN;
    self.iPhoneLanguageCode.text = currentMdoel.iPhoneLanguageCode;
    self.googleTranslationCode.text = currentMdoel.googleTranslationCode;
    self.model = currentMdoel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startAction:(UIButton *)sender {
    if (![self.model.languageIsSupportSpeech boolValue]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示框"message:@"该语言不支持语音播放" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:true completion:nil];
        return;
    }
    
    if (self.avSS.speaking) {
        //询问是否暂停
        
    } else {
        //开始读
        [self readingAloudWithString:self.contentTextField.text language: self.model.iPhoneLanguageCode];
    }
}
//暂停
- (IBAction)suspendedClick:(UIButton *)sender {
    if (!self.avSS.paused) {
        //AVSpeechBoundaryImmediate,立即停止
        //AVSpeechBoundaryWord 读完下一个词停止
        [self.avSS pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}
//继续
- (IBAction)continueClick:(UIButton *)sender {
    if (self.avSS.paused) {
        [self.avSS continueSpeaking];
    }
}
//停止
- (IBAction)stopClick:(UIButton *)sender {
    [self.avSS stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)readingAloudWithString:(NSString *)str language: (NSString *)language{
    //说话的内容
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:str];
    //语调0.5到2，默认1
    utterance.pitchMultiplier = self.pitchMultiplierSlider.value;
    self.pitchMultiplierValue.text = [NSString stringWithFormat:@"%f",self.pitchMultiplierSlider.value];
    //语速 0到1，默认是0.5
    utterance.rate = self.rateSlider.value;
    self.rateValue.text = [NSString stringWithFormat:@"%f",self.rateSlider.value];
    //音量
    utterance.volume = self.volumeValueSlider.value;
    self.volumeValue.text = [NSString stringWithFormat:@"%f",self.volumeValueSlider.value];
    
    AVSpeechSynthesisVoice *voiceType = [AVSpeechSynthesisVoice voiceWithLanguage:language];
    
    utterance.voice = voiceType;
    [self.avSS speakUtterance:utterance];
    
}

#pragma mark - 代理方法
//已经取消说话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"已经取消说话");
}

//已经继续说话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"已经继续说话");
}
//已经说完
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"经说完");
}
//已经暂停
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"已经暂停");
}

//已经开始
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"已经开始");
}
//将要说某段话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    //[utterance.speechString substringWithRange:characterRange];
    NSLog(@"将要说--%@---",[utterance.speechString substringWithRange:characterRange]);
}

@end
