//
//  ENVNeedsViewController.h
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENVNeedsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *needsAndCategories;
@property (strong, nonatomic) NSArray *needSectionTitles;
@property (strong, nonatomic) NSMutableArray *needCellTitles;
@property (copy, nonatomic) NSMutableDictionary *financialDict;

@end
