//
//  IKTAddTaskViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTAddTaskViewController.h"
#import "IKTGlobal.h"
@interface IKTAddTaskViewController ()
@property (strong, nonatomic) NSArray *priorityData;
@property (strong, nonatomic) NSArray *categoryData;
@end

@implementation IKTAddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitialSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [_priorityPickerView selectRow:2 inComponent:0 animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_taskInfoTextView.isFirstResponder){
        [_taskInfoTextView resignFirstResponder];
    }
}

- (void) loadInitialSettings{
    _categoryData = @[[IKTGlobal sharedInstance].kCategoryWork, [IKTGlobal sharedInstance].kCategoryHome, [IKTGlobal sharedInstance].kCategoryMisc];
    _priorityData = @[[IKTGlobal sharedInstance].kPriorityHigh, [IKTGlobal sharedInstance].kPriorityMedium, [IKTGlobal sharedInstance].kPriorityLow];
    _taskInfoTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _taskInfoTextView.layer.borderWidth = 1.0;
    _taskData = [[IKTTaskData alloc]init];
    _notificaitonSwitch.on = NO;
    _notificaitonSwitch.backgroundColor = [UIColor redColor];
    _notificaitonSwitch.onTintColor = [UIColor greenColor];
    _notificaitonSwitch.layer.cornerRadius = _notificaitonSwitch.frame.size.height/2;
    [_taskInfoTextView becomeFirstResponder];
    _datePickerView.userInteractionEnabled = NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)addTask:(UIButton *)sender {
    _taskData.taskInfo = _taskInfoTextView.text;
    if (_notificaitonSwitch.on && _datePickerView.date.timeIntervalSinceNow>0){
        _taskData.taskDateTime = _datePickerView.date;
    }
    if (!_taskData.taskCategory){
        _taskData.taskCategory = @"WORK";
    }
    [_delegate sendNewTaskData:_taskData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelTask:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerViews

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *data = [self getDataForPickerView:pickerView];
    NSString *title = [data objectAtIndex:row];
    return [[NSAttributedString  alloc]initWithString:title];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *data = [self getDataForPickerView:pickerView];
    if (data != nil){
        return data.count;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _priorityPickerView){
        _taskData.taskPriority = _priorityData[row];
    }else if (pickerView == _categoryPickerView){
        _taskData.taskCategory = _categoryData[row];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSArray *)getDataForPickerView:(UIPickerView *)pickerView{
    if (pickerView == _priorityPickerView){
        return _priorityData;
    }else if (pickerView == _categoryPickerView){
        return _categoryData;
    }
    return nil;
}

#pragma mark - SegmentedControl
- (IBAction)onSelectingOption:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    _taskInfoHeader.hidden = (index!=0 && index!=3);
    _taskInfoTextView.hidden = (index!=0);
    _priorityPickerView.hidden = (index!=1);
    _categoryPickerView.hidden = (index!=2);
    _datePickerView.hidden = (index!=3);
    _notificaitonSwitch.hidden = (index!=3);
    _taskInfoHeader.text = index==0 ? @"Enter Task Info" : @"Setup notification";
}

- (IBAction)onTogglingSwitch:(UISwitch *)sender {
    _datePickerView.userInteractionEnabled = sender.on;
}

#pragma mark - TextView Methods
- (void)textViewDidChange:(UITextView *)textView{
    _addBtn.enabled = textView.text.length > 2;
}


@end
