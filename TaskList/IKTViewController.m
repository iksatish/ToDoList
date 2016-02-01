//
//  IKTViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//
#import "IKTViewController.h"
#import "IKTGlobal.h"
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define GREEN RGB(66,131,0)
#define RED RGB(255,30,32)
#define YELLOW RGB(255,204,0)
@interface IKTViewController ()

@end

@implementation IKTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminateNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:[UIApplication sharedApplication]];
    [self toggleBarButtons:YES];
    _tableview.dataSource = self;
    _tabbar.selectedItem = self.tabbar.items.firstObject;
    _selectedTab = [IKTGlobal sharedInstance].kCategoryWork;
    _saveBtn.enabled = NO;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:[UIApplication sharedApplication]];
    [self toggleBarButtons:YES];
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
    return [_currentTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"datacell"];
    IKTTaskData *taskData = _currentTasks[indexPath.row];
    if ([taskData.taskPriority isEqualToString:[IKTGlobal sharedInstance].kPriorityHigh]){
        [cell setBackgroundColor:RED];
        [cell.contentView setBackgroundColor:RED];
    }else if([taskData.taskPriority isEqualToString:[IKTGlobal sharedInstance].kPriorityMedium]){
        [cell setBackgroundColor:YELLOW];
        [cell.contentView setBackgroundColor:YELLOW];
    }else{
        [cell setBackgroundColor:GREEN];
        [cell.contentView setBackgroundColor:GREEN];
    }
    cell.textLabel.text = taskData.taskInfo;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_isEditable){
        [self toggleBarButtons:NO];
    }
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSInteger noofTasks = 0;
    for (int row =0; row < [_tableview numberOfRowsInSection:indexPath.section]; row++) {
        NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
        UITableViewCell* cell = [_tableview cellForRowAtIndexPath:cellPath];
        if([cell accessoryType] == UITableViewCellAccessoryCheckmark){
            noofTasks++;
        }
    }
    [self toggleBarButtons:noofTasks==0];
}

#pragma mark Data

- (void) loadData{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[IKTGlobal sharedInstance].kTaskList_DataFile];
    NSMutableArray *fileContents = [[NSMutableArray alloc]initWithArray:[[NSArray alloc] initWithContentsOfFile:filePath]];
    _allTasks = [IKTTaskData convertFileContents:fileContents];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath
                                                contents:nil
                                              attributes:nil];
    }
    [self setCurrentTasksList:[IKTGlobal sharedInstance].kCategoryWork];
}

- (void)setCurrentTasksList:(NSString *) categoryString{
    NSString* filter = @"%K CONTAINS[cd] %@";
    NSPredicate *pred = [NSPredicate predicateWithFormat:filter, @"taskCategory", categoryString];
    _currentTasks = [[NSMutableArray alloc]initWithArray:[_allTasks filteredArrayUsingPredicate:pred]];
    [_tableview reloadData];
    _shareBtn.enabled = _currentTasks.count>0;
}

#pragma mark Tool Bar Handling Methods

- (IBAction)cancelDeletion:(UIBarButtonItem *)sender {
    [self toggleBarButtons:YES];
    [_tableview reloadData];
}

- (IBAction)shareTasks:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"sharingOptionsIdentifier" sender:nil];
    [self shareByTextMsg:@""];
}

- (IBAction)deleteTasks:(UIBarButtonItem *)sender {
    NSString *msg = @"";
    if (_isEditable){
        int section = 0;
        for (int row = (int)[_tableview numberOfRowsInSection:section]-1; row >= 0 ; row--) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [_tableview cellForRowAtIndexPath:cellPath];
            if([cell accessoryType] == UITableViewCellAccessoryCheckmark){
                [_allTasks removeObject:[_currentTasks objectAtIndex:row]];
                [_currentTasks removeObjectAtIndex:row];
            }
        }
        msg = @"Deleted Successfully!";
        [_tableview reloadData];
        _saveBtn.enabled = YES;
        _shareBtn.enabled = _currentTasks.count>0;
        [self toggleBarButtons:YES];
    }else{
        msg = @"No Task is selected";
    }
    [self showCustomMessage:msg];
}

- (IBAction)saveTasks:(UIBarButtonItem *)sender {
    [self saveTasksData];
}

- (void) saveTasksData{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, [IKTGlobal sharedInstance].kTaskList_DataFile];
    NSMutableArray *taskListArray = [IKTTaskData convertForSaving:_allTasks];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath
                                                contents:nil
                                              attributes:nil];
    }
    NSString * message = @"Saved Successfully!";
    BOOL showmsg = _saveBtn.enabled;
    if (!taskListArray || ![taskListArray writeToFile:filePath atomically:YES]){
        message = @"Error in saving tasks";
        NSLog(@"Error in writing to file");
    }else{
        _saveBtn.enabled = NO;
    }
    if (showmsg) {
        [self showCustomMessage:message];
    }
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

- (void) toggleBarButtons:(BOOL) disabled{
    self.navigationItem.rightBarButtonItem.tintColor = disabled?[UIColor clearColor]:[UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setEnabled:!disabled];
    self.deleteBtn.enabled = !disabled;
    _isEditable = !disabled;
}

#pragma mark Handling Notifications

- (void)applicationWillTerminateNotification:(NSNotification*)notification{
    [self saveTasksData];
}

#pragma mark Tabbar Methods

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch ([tabBar.items indexOfObject:item]) {
        case 0:
            _selectedTab = [IKTGlobal sharedInstance].kCategoryWork;
            break;
        case 1:
            _selectedTab = [IKTGlobal sharedInstance].kCategoryHome;
            break;
        case 2:
            _selectedTab = [IKTGlobal sharedInstance].kCategoryMisc;
            break;
        default:
            break;
    }
    [self toggleBarButtons:YES];
    [self setCurrentTasksList:_selectedTab];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"newtaskpopover"]){
        IKTAddTaskViewController *destinationController = (IKTAddTaskViewController*)segue.destinationViewController;
        destinationController.popoverPresentationController.delegate = self;
        destinationController.delegate = self;
        destinationController.preferredContentSize = CGSizeMake(320,270);
    }else if ([segue.identifier isEqualToString:@"menupopover"]){
        IKTMenuViewController *destinationController = (IKTMenuViewController*)segue.destinationViewController;
        destinationController.popoverPresentationController.delegate = self;
        destinationController.preferredContentSize = CGSizeMake(150,87);
        destinationController.delegate = self;
    }else if([segue.identifier isEqualToString:@"sharingOptionsIdentifier"]){
        IKTMenuViewController *destinationController = (IKTMenuViewController*)segue.destinationViewController;
        destinationController.popoverPresentationController.delegate = self;
        destinationController.preferredContentSize = CGSizeMake(150,87);
        destinationController.isUsedForSharing = YES;
        destinationController.delegate = self;
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection{
        return UIModalPresentationNone;
}

#pragma mark - Custom Delegate Methods

- (void)sendNewTaskData:(IKTTaskData *)newTaskData{
    [_allTasks addObject:newTaskData];
    _saveBtn.enabled = YES;
    NSString *message = @"New task is added";
    if (newTaskData.taskDateTime){
        [self setupLocalNotification:newTaskData];
        message = [NSString stringWithFormat:@"%@ and also added a notification for %@", message, newTaskData.taskDateTime];
    }
    [self showCustomMessage:message];
    [self setCurrentTasksList:[newTaskData taskCategory]];
    _selectedTab = [newTaskData taskCategory];
    if ([_selectedTab isEqualToString:[IKTGlobal sharedInstance].kCategoryWork]){
        [self.tabbar setSelectedItem:[self.tabbar.items firstObject]];
    }else if ([_selectedTab isEqualToString:[IKTGlobal sharedInstance].kCategoryHome]){
        [self.tabbar setSelectedItem:self.tabbar.items[1]];
    }else{
        [self.tabbar setSelectedItem:[self.tabbar.items lastObject]];
    }
}

- (void)selectMenuOption:(NSInteger)menuOption for:(NSInteger)usageOption{
    switch (usageOption) {
        case 0:
            if (menuOption == 0){
                UIAlertAction* okAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction * action)
                                           {
                                               NSLog(@"Dismissed Alert");
                                           }];
                NSArray *alertActions = [[NSArray alloc]initWithObjects:okAction, nil];
                NSString *message = @"Task List v1.0 \nDeveloped By Satish \n Have fun :) ";
                NSString *title = @"About";
                [self presentAlertController:title withMessage:message handlingActions:alertActions];
            }else{
                [self performSegueWithIdentifier:@"showFaqIdentifier" sender:nil];
            }
            break;
        case 1:
            [self initializeSharing:menuOption];
        default:
            break;
    }
}


#pragma mark - Sharing options

- (void) initializeSharing:(NSInteger)sharingOption{
    int section = 0, noofTasks = 0;
    NSString *msgBody = @"I am sharing these tasks with you:";
    for (int row = 0; row < (int)[_tableview numberOfRowsInSection:section]; row++) {
        NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
        UITableViewCell* cell = [_tableview cellForRowAtIndexPath:cellPath];
        if([cell accessoryType] == UITableViewCellAccessoryCheckmark){
            msgBody = [NSString stringWithFormat:@"%@\n%@", msgBody, cell.textLabel.text];
            noofTasks++;
        }
    }
    if (noofTasks == 0){
        for (IKTTaskData * data in _currentTasks){
            msgBody = [NSString stringWithFormat:@"%@\n%@", msgBody, data.taskInfo];
        }
    }
    if (sharingOption == 0){
        [self shareByEmail:msgBody];
    }else {
        [self shareByTextMsg:msgBody];
    }
}

- (void) shareByTextMsg:(NSString*) msgBody{
    MFMessageComposeViewController* composeVC = [[MFMessageComposeViewController alloc] init];
    composeVC.messageComposeDelegate = self;
    composeVC.recipients = @[@""];
    composeVC.body = msgBody;
    [self presentViewController:composeVC animated:YES completion:nil];
}

- (void) shareByEmail:(NSString*) msgBody{
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"Mail services are not available.");
        return;
    }
    MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
    composeVC.mailComposeDelegate = self;
    [composeVC setSubject:@"Tasks - To Do List"];
    [composeVC setMessageBody:msgBody isHTML:NO];
    [self presentViewController:composeVC animated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Adding Local Notifications

- (void) setupLocalNotification:(IKTTaskData*)data{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:data.taskDateTime.timeIntervalSinceNow];
    localNotification.alertBody = [NSString stringWithFormat:@"Reminder for task : %@",data.taskInfo];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark - Custom Banner Message

- (void) showCustomMessage:(NSString *)message{
    CGFloat boxHeight = 40.0;
    CGRect initialRect = CGRectMake(0, -boxHeight, self.view.frame.size.width, boxHeight);
    CGRect changedRect = CGRectMake(0, 0, self.view.frame.size.width, boxHeight);
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:initialRect];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:messageLabel];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         messageLabel.frame = changedRect;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5 delay:1.0 options:
                          UIViewAnimationOptionCurveEaseIn animations:^{
                              messageLabel.frame = initialRect;
                          } completion:^ (BOOL completed) {
                              [messageLabel removeFromSuperview];
                          }];
                     }];
}

@end
