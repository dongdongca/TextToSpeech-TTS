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
#import "LanguageListModel.h"

@interface SelectedCountryViewController ()
//数据
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SelectedCountryViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SpeechLanguageList.plist" ofType: nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _dataSource = [NSMutableArray arrayWithCapacity:array.count];
        for (int i = 0; i < array.count; i++) {
            LanguageListModel *model = [LanguageListModel languageListModelWithDict:array[i]];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国家";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"selectedCountryCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TextToSpeechViewController *ttsVC = [[TextToSpeechViewController alloc] init];
    ttsVC.row = indexPath.row;
    ttsVC.dataSource = self.dataSource;
    [self.navigationController pushViewController:ttsVC animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    LanguageListModel *model = self.dataSource[indexPath.row];
    cell.countryName.text = model.languagesOrCountry;
    
    return cell;
}




@end
