//
//  CLQViewController.m
//  Culqi
//
//  Created by Guillermo Saenz on 09/18/2016.
//  Copyright (c) 2016 Guillermo Saenz. All rights reserved.
//

#import "CLQViewController.h"

@import Culqi;

@interface CLQViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldExpMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldExpYear;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldCVC;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldLastName;

@end

@implementation CLQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Test Data

- (void)setTestData {
    
    [self.txtFieldCardNumber setText:@"4111111111111111"];
    [self.txtFieldExpMonth setText:@"09"];
    [self.txtFieldExpYear setText:@"2020"];
    [self.txtFieldCVC setText:@"123"];
    
    [self.txtFieldEmail setText:@"jhon@test.com"];
    [self.txtFieldName setText:@"Jhon"];
    [self.txtFieldLastName setText:@"Test"];
}

#pragma mark - Actions

- (IBAction)setTestDataActn:(id)sender {
    [self setTestData];
    [self.view endEditing:YES];
}

- (IBAction)createTokenActn:(id)sender {
    
    // TODO: validate fields
    
    [[Culqi sharedInstance] createTokenWithCardNumber:self.txtFieldCardNumber.text cvv:self.txtFieldCVC.text expirationMonth:self.txtFieldExpMonth.text expirationYear:self.txtFieldExpYear.text email:self.txtFieldEmail.text metadata:nil success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
        NSLog(@"Did create token with identifier: %@", token.identifier);
    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
        NSLog(@"Error Creating token\nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
    }];
}

@end
