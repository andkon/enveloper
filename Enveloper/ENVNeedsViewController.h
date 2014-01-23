//
//  ENVNeedsViewController.h
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENVNeedsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// Properties for the table view!
@property (strong, nonatomic) NSMutableDictionary *needsAndCategories;
@property (strong, nonatomic) NSArray *needSectionTitles;
@property (strong, nonatomic) NSMutableArray *needCellTitles;

// Properties for the model!
@property (strong, nonatomic) NSMutableDictionary *financialDict;
@property (strong, nonatomic) NSMutableDictionary *needsDict;

@end
