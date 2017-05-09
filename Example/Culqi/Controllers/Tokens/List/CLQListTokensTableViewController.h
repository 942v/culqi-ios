//
//  CLQListTokensTableViewController.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLQListTokensTableViewControllerDelegate;

@interface CLQListTokensTableViewController : UITableViewController

@property (nonatomic, weak) id <CLQListTokensTableViewControllerDelegate> delegate;

@end

@protocol CLQListTokensTableViewControllerDelegate <NSObject>

- (void)listTokensTableViewController:(CLQListTokensTableViewController *)listTokensTableViewController didSelectTokenWithIdentifier:(NSString *)tokenIdentifier;

@end
