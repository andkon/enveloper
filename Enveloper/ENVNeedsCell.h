//
//  ENVNeedsCell.h
//  Enveloper
//
//  Created by AK on 1/22/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENVNeedsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *needAmount;

- (IBAction)needAmountFinishedEditing:(id)sender;

@end
