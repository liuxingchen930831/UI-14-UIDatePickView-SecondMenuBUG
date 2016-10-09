//
//  ViewController.m
//  生日键盘
//
//  Created by liuxingchen on 16/10/8.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "CityModel.h"
@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *SRLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityLabel;
@property(nonatomic,strong)UIDatePicker * datePicker ;
/** 城市PickerView */
@property(nonatomic,strong)UIPickerView * pickerView ;
/** 数据源 */
@property(nonatomic,strong)NSMutableArray * provinces ;
/**
 *  记录下选中省
 */
@property(nonatomic,assign)NSInteger proIndex;
@end

@implementation ViewController
-(NSMutableArray *)provinces
{
    if (_provinces ==nil) {
        _provinces = [NSMutableArray arrayWithCapacity:0];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil];
        NSArray *provincesArray = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in provincesArray) {
            CityModel *model = [CityModel cityWithDict:dict];
            [_provinces addObject:model];
        }
    }
    return _provinces;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.SRLabel.delegate = self;
    self.cityLabel.delegate = self;
    [self setUpKayboard];
    [self setUpCityKeyboard];
}
#pragma mark - SRKeyboard
-(void)setUpKayboard
{
    self.datePicker = [[UIDatePicker alloc]init];
    //打印frame
    NSLog(@"rect = %@",NSStringFromCGRect(self.datePicker.frame));
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //语言本地化设置，zh == 中国
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [self.datePicker addTarget:self action:@selector(dateChage:) forControlEvents:UIControlEventValueChanged];
    //自定义UITextField键盘样式
    self.SRLabel.inputView = self.datePicker;
}
//是否允许输入字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}
//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField ==self.SRLabel) {
        [self dateChage:self.datePicker];
    }else{
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    }
    
}
-(void)dateChage:(UIDatePicker *)datePicker
{
    //日期类型转字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self.datePicker.date];
    self.SRLabel.text = dateStr;
}
#pragma mark - CityKeyboard
-(void)setUpCityKeyboard
{
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.cityLabel.inputView = self.pickerView;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return  self.provinces.count;
    }else{
        CityModel *city = self.provinces[self.proIndex];
        return city.cities.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component ==0) {
        CityModel *shengName = self.provinces[row];
        return shengName.name;
    }else{
        // 当前选中的内蒙古省，只有12个城市，角标0~11，但是右边城市是北京，北京的城市大于12个城市，所以滚动的时候会出现越界。
        CityModel *shiName = self.provinces[self.proIndex];
        return shiName.cities[row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component ==0) {
        // 记录当前选中的省会
        self.proIndex = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
    }
    //获取省
    CityModel *sheng = self.provinces[self.proIndex];
    //获取市角标
    NSInteger indexCity = [pickerView selectedRowInComponent:1];
    //获取市
    CityModel *shi = sheng.cities[indexCity];
    self.cityLabel.text = [NSString stringWithFormat:@"%@ %@",sheng.name,shi];
}
@end
