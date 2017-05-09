//
//  CLQTokenViewController.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import "CLQTokenViewController.h"

@import Culqi;
@import SVProgressHUD;

@interface CLQTokenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@property (weak, nonatomic) IBOutlet UITextField *textFieldMetadataKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMetadataObject;

@property (nonatomic, strong) CLQToken *token;

@end

@implementation CLQTokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    [[Culqi sharedInstance] getTokenWithIdentifier:self.tokenIdentifier
                                           success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
                                               [SVProgressHUD dismiss];
                                               NSLog(@"Did find token: %@", token);
                                               self.token = token;
                                               [self updateUI];
                                           }
                                           failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                               [SVProgressHUD dismiss];
                                               NSLog(@"Error getting token \nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
                                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

- (void)updateUI {
    
    NSString *infoLabelText = [NSString stringWithFormat:@"identifier: %@\ntype: %@\nemail: %@\ncreationDate: %@\ncardNumber: %@\nactive: %@\nmetadata: %@", self.token.identifier, self.token.type, self.token.email, self.token.creationDate, self.token.cardNumber, self.token.active?@"YES":@"NO", self.token.metadata];
    self.labelInfo.text = infoLabelText;
}

#pragma mark - Actions

- (IBAction)updateTokenAction:(id)sender {
    
    NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithDictionary:self.token.metadata];
    
    [metadata setObject:self.textFieldMetadataObject.text forKey:self.textFieldMetadataKey.text];
    
    [SVProgressHUD show];
    [[Culqi sharedInstance] updateTokenWithIdentifier:self.token.identifier
                                             metadata:metadata.copy
                                              success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
                                                  [SVProgressHUD dismiss];
                                                  NSLog(@"Did update token: %@", token);
                                                  self.token = token;
                                                  [self updateUI];
                                              }
                                              failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                                  [SVProgressHUD dismiss];
                                                  NSLog(@"Error updating token \nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
                                              }];
}

@end
