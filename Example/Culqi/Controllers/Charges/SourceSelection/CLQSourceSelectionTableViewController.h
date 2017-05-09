//
//  CLQSourceSelectionTableViewController.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLQSourceSelectionTableViewControllerDelegate;

@interface CLQSourceSelectionTableViewController : UITableViewController

@property (nonatomic, weak) id <CLQSourceSelectionTableViewControllerDelegate> delegate;

@end

@protocol CLQSourceSelectionTableViewControllerDelegate <NSObject>

- (void)sourceSelectionTableViewController:(CLQSourceSelectionTableViewController *)sourceSelectionTableViewController didSelectIdentifier:(NSString *)selectedIdentifier;

@end
