//
//  IKMenuViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/31/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTMenuViewController.h"

@interface IKTMenuViewController ()

@end

@implementation IKTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"datacell"];
    if (indexPath.row == 0){
        cell.textLabel.text = @"About";
    }else{
        cell.textLabel.text = @"FAQ/Directions";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate selectMenuOption:indexPath.row];
}
@end
