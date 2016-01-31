//
//  IKTMenuViewController.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/31/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKTMenuDelegate<NSObject>
- (void)selectMenuOption:(NSInteger)menuOption;
@end

@interface IKTMenuViewController : UITableViewController

@property (weak,nonatomic) id <IKTMenuDelegate> delegate;
@end
