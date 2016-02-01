//
//  IKTSimpleLoginViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/31/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTSimpleLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
- (IBAction)doFormAction:(UIButton *)sender;
- (IBAction)textFieldValueChange:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
