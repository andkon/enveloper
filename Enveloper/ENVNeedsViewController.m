//
//  ENVNeedsViewController.m
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import "ENVNeedsViewController.h"
#import "ENVNavViewController.h"
#import "ENVAppDelegate.h"

@interface ENVNeedsViewController ()

@end

@implementation ENVNeedsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    if (self.financialDict == nil) {
        ENVAppDelegate *launchedDelegate = (ENVAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.financialDict = launchedDelegate.financialDict;
    }
    
    self.needCellTitles = [[NSMutableArray alloc] initWithCapacity:0];
    self.needSectionTitles = [[NSArray alloc] initWithObjects:@"Auto and Transport", @"Bills and Utilities", @"Business Costs", @"Education", @"Banking & Financial", @"Food", @"Health and Fitness", @"Home", @"Kids", @"Misc. Expenses", @"Pets", @"Taxes", @"Emergency Travel", nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"needs"
                                                     ofType:@"plist"];
    self.needsAndCategories = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    // Now I need to put all the needs in an ordered array.
    for (id object in self.needSectionTitles) {
        NSArray *needsFromSingleCategory = [self.needsAndCategories valueForKey:object];
        [self.needCellTitles addObject:needsFromSingleCategory];
    }
    
    
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.needSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.needSectionTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = self.needSectionTitles[section];
    NSArray *sectionNeeds = [self.needsAndCategories valueForKey:sectionTitle];
    return [sectionNeeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NeedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    UILabel *needTitle = (UILabel *)[cell viewWithTag:100];
    NSArray *titlesForSection = self.needCellTitles[indexPath.section];
    needTitle.text = titlesForSection[indexPath.row];
    
    UITextField *needAmount = (UITextField *)[cell viewWithTag:101];
    NSDictionary *wants = [self.financialDict valueForKey:@"wants"];
    
    if ([wants valueForKey:needTitle.text] != nil) {
        needAmount.text = [[wants valueForKey:needTitle.text] stringValue];
    } else {
        needAmount.text = @"0";
    }

    return cell;
}



#pragma mark -
#pragma mark Table View Delegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // maybe pop up the $$$ keyboard thing
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *needAmount = (UITextField *)[cell viewWithTag:101];
    [needAmount becomeFirstResponder];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 1. dismiss numpad if it's first responder
    // 2. get everything in the cells
    // 3. Update *self.incomeNeedsDict: {@"%s" : @%ul} %s = the cell title, and %ul is the $ value (if it's nil, put 0).
    // 4. then the stuff below where you pass it on to incomeNeedsWantsDict
    [self.tableView resignFirstResponder];
    
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setDelegate:)]) {
        [destination setValue:destination forKey:@"delegate"];
    }
    if ([destination respondsToSelector:@selector(setFinancialDict:)]) {
        [destination setValue:self.financialDict forKey:@"financialDict"];
    }
}


@end
