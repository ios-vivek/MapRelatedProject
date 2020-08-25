//
//  ViewController.m
//  ObjectiveCProj
//
//  Created by Vivek on 8/10/20.
//  Copyright © 2020 Vivek. All rights reserved.
//

#import "ViewController.h"
#import "CalculationClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)okButtonTapped:(UIButton *)sender {
NSLog(@"Ok button was tapped: dismiss the view controller.");
   // CalculationClass *obj = [CalculationClass init];
    NSLog(@"%f",[CalculationClass addTwoItem:2.0 with:3.0]);
}

@end
