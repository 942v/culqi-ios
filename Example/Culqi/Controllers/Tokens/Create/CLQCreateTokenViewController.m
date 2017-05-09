//
//  CLQCreateTokenViewController.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import "CLQCreateTokenViewController.h"

@import Culqi;
@import SVProgressHUD;

@interface CLQCreateTokenViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldExpMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldExpYear;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldCVC;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldLastName;

@end

@implementation CLQCreateTokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [SVProgressHUD show];
    [[Culqi sharedInstance] createTokenWithCardNumber:self.txtFieldCardNumber.text cvv:self.txtFieldCVC.text expirationMonth:self.txtFieldExpMonth.text expirationYear:self.txtFieldExpYear.text email:self.txtFieldEmail.text metadata:nil success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
        [SVProgressHUD dismiss];
        NSLog(@"Did create token with identifier: %@", token.identifier);
    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"Error Creating token\nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
    }];
}

@end
