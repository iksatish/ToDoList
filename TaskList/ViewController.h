//
//  ViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableDictionary *tasksDictionary;
@property (strong, nonatomic) NSMutableArray *selectedTasks;
@property (nonatomic) BOOL isEditable;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)addNewTask:(UIBarButtonItem *)sender;
- (IBAction)deleteTasks:(UIBarButtonItem *)sender;
- (IBAction)saveTasks:(UIBarButtonItem *)sender;
- (IBAction)cancelDeletion:(UIBarButtonItem *)sender;


@end

