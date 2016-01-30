//
//  ViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableDictionary *tasksDictionary;
@property (strong, nonatomic) NSMutableArray *selectedTasks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadTempData];
    _selectedTasks = [[NSMutableArray alloc] initWithArray:[self getDataForCurrentTab:@"Category1"]];
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
    [[cell textLabel] setText:_selectedTasks[indexPath.row]];
    return cell;
}

#pragma mark Data

- (void) loadTempData{
    NSArray *temp1 = @[@"CT1Task1", @"CT1Task2", @"CT1Task3", @"CT1Task4", @"CT1Task5"];
    NSArray *temp2 = @[@"CT2Task1", @"CT2Task2", @"CT2Task3", @"CT2Task4", @"CT2Task5"];
    _tasksDictionary = [[NSMutableDictionary alloc]init];
    [_tasksDictionary setValue:temp1 forKey:@"Category1"];
    [_tasksDictionary setValue:temp2 forKey:@"Category2"];
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

@end
