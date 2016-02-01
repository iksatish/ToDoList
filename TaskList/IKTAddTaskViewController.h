//
//  IKTAddTaskViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTTaskData.h"

@protocol IKTAddNewTaskDelegate<NSObject>
- (void)sendNewTaskData:(IKTTaskData*)newTaskData;
@end

@interface IKTAddTaskViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlView;
@property (weak, nonatomic) IBOutlet UITextView *taskInfoTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *taskInfoHeader;
@property (strong, nonatomic) NSMutableDictionary *selectedPickerViewData;
@property (strong, nonatomic) IKTTaskData *taskData;
@property (weak,nonatomic) id <IKTAddNewTaskDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *notificaitonSwitch;


- (IBAction)addTask:(UIButton *)sender;
- (IBAction)cancelTask:(UIButton *)sender;
- (IBAction)onSelectingOption:(UISegmentedControl *)sender;
- (IBAction)onTogglingSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
