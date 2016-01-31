//
//  AddTaskViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"
@protocol AddNewTaskDelegate<NSObject>
- (void)sendNewTaskData:(NSMutableDictionary*)newTaskData;
@end

@interface AddTaskViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlView;
@property (weak, nonatomic) IBOutlet UITextView *taskInfoTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *taskInfoHeader;
@property (strong, nonatomic) NSMutableDictionary *selectedPickerViewData;
@property (nonatomic, weak) id <AddNewTaskDelegate> delegate;


- (IBAction)addTask:(UIButton *)sender;
- (IBAction)cancelTask:(UIButton *)sender;
- (IBAction)onSelectingOption:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
