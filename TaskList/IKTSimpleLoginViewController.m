//
//  IKTSimpleLoginViewController.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/31/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTSimpleLoginViewController.h"
#import "IKTViewController.h"
@interface IKTSimpleLoginViewController ()

@end

@implementation IKTSimpleLoginViewController

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

- (IBAction)doFormAction:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [_userIdTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![defaults valueForKey:_userIdTextField.text]){
        [defaults setValue:@"Dummy Value" forKey:_userIdTextField.text];
    }
    [self navigateToTaskList:[NSString stringWithFormat:@"%@TaskList.plist",userId]];
}

- (void) navigateToTaskList:(NSString *)fileName{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    IKTViewController * homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    homeVC.fileName = fileName;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homeVC]];
}

@end
