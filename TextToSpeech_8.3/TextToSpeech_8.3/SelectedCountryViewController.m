//
//  SelectedCountryViewController.m
//  TextToSpeech_8.3
//
//  Created by 李东 on 2017/8/28.
//  Copyright © 2017年 李东. All rights reserved.
//

#import "SelectedCountryViewController.h"
#import "selectedCountryCell.h"
#import "TextToSpeechViewController.h"
#import "TTSModel.h"

@interface SelectedCountryViewController ()
//数据
@property (nonatomic, strong) NSDictionary *dataSource;
//国家数据
@property (nonatomic, strong) NSArray *countryArray;

@end

@implementation SelectedCountryViewController

- (NSDictionary *)dataSource {
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LanguageList.plist" ofType: nil];
        _dataSource = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _dataSource;
}

- (NSArray *)countryArray {
    if (!_countryArray) {
        _countryArray = [[NSArray alloc] init];
    }
    return _countryArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国家";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"selectedCountryCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.countryArray = self.dataSource.allKeys;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TextToSpeechViewController *ttsVC = [[TextToSpeechViewController alloc] init];
    ttsVC.dict  = [TTSModel modelWithDict:self.dataSource[self.countryArray[indexPath.row]]];
    [self.navigationController pushViewController:ttsVC animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.countryName.text = self.countryArray[indexPath.row];
    
    return cell;
}




@end
