//
//  IKTViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTAddTaskViewController.h"
#import "IKTMenuViewController.h"
@interface IKTViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, UIPopoverPresentationControllerDelegate, IKTAddNewTaskDelegate, IKTMenuDelegate>

@property (strong, nonatomic) NSMutableArray *allTasks;
@property (strong, nonatomic) NSMutableArray *currentTasks;
@property (nonatomic) BOOL isEditable;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (strong, nonatomic) NSString *selectedTab;

- (IBAction)deleteTasks:(UIBarButtonItem *)sender;
- (IBAction)saveTasks:(UIBarButtonItem *)sender;
- (IBAction)cancelDeletion:(UIBarButtonItem *)sender;


@end

