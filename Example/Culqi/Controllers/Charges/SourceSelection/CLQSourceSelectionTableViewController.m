//
//  CLQSourceSelectionTableViewController.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import "CLQSourceSelectionTableViewController.h"

#import "CLQListTokensTableViewController.h"

@interface CLQSourceSelectionTableViewController () <CLQListTokensTableViewControllerDelegate>

@end

@implementation CLQSourceSelectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLQListTokensTableViewControllerDelegate

- (void)listTokensTableViewController:(CLQListTokensTableViewController *)listTokensTableViewController didSelectTokenWithIdentifier:(NSString *)tokenIdentifier {
    
    if ([self.delegate respondsToSelector:@selector(sourceSelectionTableViewController:didSelectIdentifier:)]) [self.delegate sourceSelectionTableViewController:self didSelectIdentifier:tokenIdentifier];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ListTokensSID"]) {
        CLQListTokensTableViewController *listTokensTableViewController = segue.destinationViewController;
        [listTokensTableViewController setDelegate:self];
    }else if ([segue.identifier isEqualToString:@"ListCardsSID"]) {
        // TODO: finish this
    }
}

@end
