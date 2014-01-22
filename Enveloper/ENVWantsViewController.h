//
//  ENVWantsViewController.h
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

/*
 The structure of the model:
 [ { Section titles : 
        [ { Want item title : $$ value},
          { ... : ... },
          { ... : ... }
          nil
        ]
    },
    { ... : ...},
    { ... : ...}
 ]
 
 */

#import <UIKit/UIKit.h>

@interface ENVWantsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *wantText;
@property (strong, nonatomic) NSMutableArray *wantsItems;
@property (strong, nonatomic) NSArray *sectionTitles; // For the section titles.
@property (copy, nonatomic) NSMutableDictionary *financialDict;

@end
