//
//  ENVIncomeViewController.m
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import "ENVIncomeViewController.h"
#import "ENVAppDelegate.h"

static ENVAppDelegate *launchedDelegate;

@implementation ENVIncomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    launchedDelegate = (ENVAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (self.financialDict == nil) {
        self.financialDict = launchedDelegate.financialDict;
    }
    NSString *savedIncome = [[self.financialDict valueForKey:@"income"] stringValue];
    self.income.text = savedIncome;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSNumber *incomeAmount = [[NSNumber alloc] initWithInt:[self.income.text intValue]];
    [self.financialDict setObject:incomeAmount forKey:@"income"];
    
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setDelegate:)]) {
        [destination setValue:destination forKey:@"delegate"];
    }
    if ([destination respondsToSelector:@selector(setFinancialDict:)]) {
        [destination setValue:self.financialDict forKey:@"financialDict"];
    }
    launchedDelegate.financialDict = self.financialDict;
}

@end
