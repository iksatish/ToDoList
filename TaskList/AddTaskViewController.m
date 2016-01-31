//
//  AddTaskViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()
@property (strong, nonatomic) NSArray *priorityData;
@property (strong, nonatomic) NSArray *categoryData;
@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _categoryData = @[@"Work", @"Home", @"Miscellaneous"];
    _priorityData = @[@"High", @"Medium", @"Low"];
    _taskInfoTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _taskInfoTextView.layer.borderWidth = 1.0;
    _selectedPickerViewData = [[NSMutableDictionary alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_selectedPickerViewData setValue:_taskInfoTextView.text forKey:@"TASKINFO"];
    [_delegate sendNewTaskData:_selectedPickerViewData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelTask:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadDataToPickerViews{
    
    _priorityPickerView.delegate = self;
    _priorityPickerView.dataSource = self;
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
    NSArray *data = [self getDataForPickerView:pickerView];
    [_selectedPickerViewData setValue:data[row] forKey:[self getKeyForPickerView:pickerView]];
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
- (NSString *)getKeyForPickerView:(UIPickerView *)pickerView{
    if (pickerView == _priorityPickerView){
        return @"PRIORITY";
    }else if (pickerView == _categoryPickerView){
        return @"CATEGORY";
    }
    return @"DATETIME";
}

#pragma mark - SegmentedControl
- (IBAction)onSelectingOption:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    _taskInfoTextView.hidden = (index!=0);
    _taskInfoHeader.hidden = (index!=0);
    _priorityPickerView.hidden = (index!=1);
    _categoryPickerView.hidden = (index!=2);
    _datePickerView.hidden = (index!=3);
}

#pragma mark - TextView Methods
- (void)textViewDidChange:(UITextView *)textView{
    _addBtn.enabled = textView.text.length > 2;
}


@end
