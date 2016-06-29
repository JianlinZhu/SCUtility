//
//  SCViewController.m
//  SCUtility
//
//  Created by Jarry on 06/29/2016.
//  Copyright (c) 2016 Jarry. All rights reserved.
//

#import "SCViewController.h"
#import "SCUtility.h"

@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [SCLog initLog];
    
    DEBUGLOG(@"Debug Log");
    WARNLOG(@"Warning Log");
    ERRORLOG(@"Error Log");
    VERBOSELOG(@"VERBOSE Log");
    INFOLOG(@"Info Log");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
