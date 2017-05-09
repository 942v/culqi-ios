//
//  CLQListTokensTableViewController.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import "CLQListTokensTableViewController.h"

@import Culqi;
@import SVProgressHUD;

#import "CLQTokenViewController.h"

@interface CLQListTokensTableViewController ()

@property (nonatomic, strong) NSArray <CLQToken *> *tokens;

@end

@implementation CLQListTokensTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    [[Culqi sharedInstance] getTokensWithFromUnixDate:nil
                                           toUnixDate:nil
                                            cardBrand:nil
                                             cardType:CLQCardTypeUnkown
                                           deviceType:nil
                                                  bin:nil
                                          countryCode:nil
                                                limit:nil
                                beforeTokenIdentifier:nil
                                 afterTokenIdentifier:nil
                                              success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQPaging * _Nonnull paging, NSArray<CLQToken *> * _Nonnull tokens) {
                                                  [SVProgressHUD dismiss];
                                                  NSLog(@"Did find tokens: %@", tokens);
                                                  self.tokens = tokens;
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                                  [SVProgressHUD dismiss];
                                                  NSLog(@"Error getting tokens \nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
                                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tokens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CLQToken *token = [self.tokens objectAtIndex:indexPath.row];
    cell.textLabel.text = token.email;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLQToken *token = [self.tokens objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(listTokensTableViewController:didSelectTokenWithIdentifier:)]) [self.delegate listTokensTableViewController:self didSelectTokenWithIdentifier:token.identifier];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"TokenDetailsSID"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        CLQToken *token = [self.tokens objectAtIndex:indexPath.row];
        CLQTokenViewController *tokenViewController = segue.destinationViewController;
        [tokenViewController setTokenIdentifier:token.identifier];
    }
}

@end
