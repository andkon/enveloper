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
#import "ENVNeedsCell.h"

static ENVAppDelegate *launchedDelegate;

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
    
    // See if we've saved a financialDict already
    launchedDelegate = (ENVAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (self.financialDict == nil) {
        self.financialDict = launchedDelegate.financialDict;
    }
    
    
    // Get the titles and section titles for the cells
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
    
    // With cell arrays and so on already made, now I need to
    // initialize the array which will contain the need values for each cell,
    // and which will be saved back into launchedDelegate.financialDict at the end
    // of this file.
    if ([self.financialDict valueForKey:@"needs"] == nil) {
            self.needsDict = [[NSMutableDictionary alloc] init];
    } else {
        self.needsDict = [[NSMutableDictionary alloc] initWithDictionary:self.financialDict[@"needs"]];
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
    // Create a cell & register it for dequeing
    static NSString *CellIdentifier = @"NeedCell";
    ENVNeedsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Get an array of cell names for a given section
    NSArray *titlesForSection = self.needCellTitles[indexPath.section];

    // Set the title of the cell.
    cell.needTitle.text = titlesForSection[indexPath.row];
    
    
    // Setting the cell's needAmount property
    // 1. Set the delegate to be this view controller
    // 2. Find out if there's a key in the self.needsDict. If not, set it to zero.
    cell.needAmount.delegate = self;
    
    NSString *key = cell.needTitle.text;
    
    if ([self.needsDict valueForKey:key] != nil) {
        cell.needAmount.text = [[self.needsDict valueForKey:cell.needTitle.text] stringValue];
    } else {
        cell.needAmount.text = @"0";
    }

    return cell;
}

#pragma mark Text Field Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    UILabel *needTitle = (UILabel *)[textField.superview viewWithTag:100];
    NSString *needName = needTitle.text;
    NSNumber *needValue = [[NSNumber alloc] initWithInt:[textField.text intValue]];
    [self.needsDict setObject:needValue forKey:needName];
}

#pragma mark -
#pragma mark Table View Delegate Methods

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
    // Resign first responder
    [self.view endEditing:YES];
    
    [self.financialDict setObject:self.needsDict forKey:@"needs"];
    
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
