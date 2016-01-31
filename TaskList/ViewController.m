//
//  ViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

NSString * const TASKDESC = @"taskDesc";
NSString * const TASKPRIORITY = @"taskPriority";
NSString * const TASKCATEGORY = @"taskCategory";
NSString * const TASKDATETIME = @"taskDateTime";
NSString * const TASKLIST_DATAFILE = @"tasklistfile.plist";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadTempData];
    _isEditable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminateNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:[UIApplication sharedApplication]];
    [self disableBarButton:self.navigationItem.rightBarButtonItem needsDisabled:YES];
    self.tabbar.selectedItem = self.tabbar.items.firstObject;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:[UIApplication sharedApplication]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_selectedTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"datacell"];
    NSDictionary *taskData = _selectedTasks[indexPath.row];
    cell.textLabel.text = [taskData valueForKey:TASKDESC];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    UILongPressGestureRecognizer * gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(selectCell:)];
    [cell addGestureRecognizer:gesture];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isEditable){
        UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)selectCell:(UIGestureRecognizer*)gesture{
    UITableViewCell *cell = (UITableViewCell*)gesture.view;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self disableBarButton:self.navigationItem.rightBarButtonItem needsDisabled:NO];
    _isEditable = YES;
}
#pragma mark Data

- (void) loadTempData{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,TASKLIST_DATAFILE];
    _selectedTasks = [[NSMutableArray alloc]initWithArray:[[NSArray alloc] initWithContentsOfFile:filePath]];
    if (!_selectedTasks){
        _selectedTasks = [[NSMutableArray alloc]init];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath
                                                contents:nil
                                              attributes:nil];
    }
}

- (NSArray*) getDataForCurrentTab : (NSString *) category{
    if (_tasksDictionary != nil){
        NSArray *temp1 = [_tasksDictionary valueForKey: category];
        if (temp1 != nil){
            return temp1;
        }
    }
    return nil;
}

#pragma mark Add New Task
//
//- (void) addNewTask{
//    UIAlertController *newTaskAlertController = [UIAlertController alertControllerWithTitle:@"Add New Task" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [newTaskAlertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
//        textField.placeholder = NSLocalizedString(@"Add your task", @"NewTaskPlaceholder");
//        [textField addTarget:self
//                      action:@selector(alertTextFieldDidChange:)
//            forControlEvents:UIControlEventEditingChanged];
//    }];
//    UIAlertAction *addAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Add", @"add action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        [self addTaskFromDialogBox:newTaskAlertController.textFields.firstObject.text];
//        NSLog(@"Added");
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction
//                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
//                                   style:UIAlertActionStyleCancel
//                                   handler:^(UIAlertAction *action)
//                                   {
//                                       NSLog(@"Cancel action");
//                                   }];
//    [newTaskAlertController addAction:addAction];
//    [newTaskAlertController addAction:cancelAction];
//    [addAction setEnabled:NO];
//    [self presentViewController:newTaskAlertController animated:YES completion:nil];
//}

- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.firstObject;
        okAction.enabled = login.text.length > 2;
    }
}

- (IBAction)cancelDeletion:(UIBarButtonItem *)sender {
    _isEditable = NO;
    [_tableview reloadData];
    [self disableBarButton:self.navigationItem.rightBarButtonItem needsDisabled:YES];
}

- (IBAction)addNewTask:(UIBarButtonItem *)sender {
//    [self addNewTask];
//    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController") as! UIViewController
//    vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//    let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//    popover.barButtonItem = sender
//    presentViewController(vc, animated: true, completion:nil)
//}
}

- (IBAction)deleteTasks:(UIBarButtonItem *)sender {
    if (_isEditable){
        int section = 0;
        for (int row = (int)[_tableview numberOfRowsInSection:section]-1; row >= 0 ; row--) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [_tableview cellForRowAtIndexPath:cellPath];
            if([cell accessoryType] == UITableViewCellAccessoryCheckmark){
                [_selectedTasks removeObjectAtIndex:row];
            }
        }
        [_tableview reloadData];
        [self disableBarButton:self.navigationItem.rightBarButtonItem needsDisabled:YES];
        _isEditable = NO;
    }else{
        NSMutableArray *alertActions = [[NSMutableArray alloc]init];
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"Dismissed Alert");
                                   }];
        [alertActions addObject:okAction];
        NSString *message = @"No Task is selected";
        NSString *title = @"Delete Tasks";
        [self presentAlertController:title withMessage:message handlingActions:alertActions];

    }
}

- (IBAction)saveTasks:(UIBarButtonItem *)sender {
    [self saveTasksData];
}

- (void) saveTasksData{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, TASKLIST_DATAFILE];
    NSMutableArray *taskListArray = [[NSMutableArray alloc] initWithArray:_selectedTasks];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath
                                                contents:nil
                                              attributes:nil];
        taskListArray = [[NSMutableArray alloc]init];
    }
    NSString * message = @"Saved Successfully!";
    if (!taskListArray || ![taskListArray writeToFile:filePath atomically:YES]){
        message = @"Error in saving tasks";
        NSLog(@"Error in writing to file");
    }
    NSMutableArray *alertActions = [[NSMutableArray alloc]init];
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action)
                               {
                                   NSLog(@"Dismissed Alert");
                               }];
    [alertActions addObject:okAction];
    [self presentAlertController:@"Save Tasks" withMessage:message handlingActions:alertActions];
}

- (void) addTaskFromDialogBox:(NSMutableDictionary *)newTaskData{
    
    NSMutableDictionary *taskdict = [[NSMutableDictionary alloc] init];
    [taskdict setValue:[newTaskData valueForKey:@"TASKINFO"] forKey:TASKDESC];
    [taskdict setValue:[newTaskData valueForKey:@"PRIORITY"] forKey:TASKPRIORITY];
    [taskdict setValue:[newTaskData valueForKey:@"CATEGORY"] forKey:TASKCATEGORY];
    [taskdict setValue:[newTaskData valueForKey:@"DATETIME"] forKey:TASKDATETIME];
    [_selectedTasks addObject:taskdict];
    [_tableview reloadData];
}

#pragma mark AlertController    

- (void)presentAlertController:(NSString*)title withMessage:(NSString*)message handlingActions:(NSArray*)actions{
    UIAlertController * alertController=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    for (UIAlertAction *action in actions){
        [alertController addAction:action];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Toggle Bar button

- (void) disableBarButton:(UIBarButtonItem *)barButton needsDisabled:(BOOL) disabled{
    barButton.tintColor = disabled?[UIColor clearColor]:[UIColor blueColor];
    barButton.enabled = !disabled;
}

#pragma mark Handling Notifications

- (void)applicationWillTerminateNotification:(NSNotification*)notification{
    [self saveTasksData];
}

#pragma mark Tabbar Methods

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"%lu",[tabBar.items indexOfObject:item]);
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"newtaskpopover"]){
        AddTaskViewController *desinationController = (AddTaskViewController*)segue.destinationViewController;
        desinationController.popoverPresentationController.delegate = self;
        desinationController.delegate = self;
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
}

#pragma mark - New Task Delegate

- (void)sendNewTaskData:(NSMutableDictionary *)newTaskData{
    [self addTaskFromDialogBox:newTaskData];
}

@end
