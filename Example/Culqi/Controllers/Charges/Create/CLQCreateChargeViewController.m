//
//  CLQCreateChargeViewController.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright © 2017 Guillermo Saenz. All rights reserved.
//

#import "CLQCreateChargeViewController.h"

#import "CLQSourceSelectionTableViewController.h"

@import Culqi;
@import SVProgressHUD;

@interface CLQCreateChargeViewController () <UIPopoverPresentationControllerDelegate, CLQSourceSelectionTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrencyCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInstallments;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSourceIdentifier;

@end

@implementation CLQCreateChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLQSourceSelectionTableViewControllerDelegate

- (void)sourceSelectionTableViewController:(CLQSourceSelectionTableViewController *)sourceSelectionTableViewController didSelectIdentifier:(NSString *)selectedIdentifier {
    
    NSLog(@"selectedIdentifier: %@", selectedIdentifier);
    self.textFieldSourceIdentifier.placeholder = selectedIdentifier;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - Actions

- (IBAction)createChargeAction:(id)sender {
    
    // TODO: validate fields
    [SVProgressHUD show];
    [[Culqi sharedInstance] createChargeWithAmount:@(self.textFieldAmount.text.doubleValue*100)
                                           capture:NO
                                      currencyCode:[CLQCurrencyCode getCurrencyCodeTypeEnumForKey:self.textFieldCurrencyCode.text]
                                       description:self.textFieldDescription.text
                                             email:self.textFieldEmail.text
                                      installments:@(self.textFieldInstallments.text.integerValue)
                                  antifraudDetails:nil
                                  sourceIdentifier:self.textFieldSourceIdentifier.placeholder
                                          metadata:nil
                                           success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQCharge * _Nonnull charge) {
                                               [SVProgressHUD dismiss];
                                               NSLog(@"Did create charge with identifier: %@", charge.identifier);
                                           }
                                           failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                               [SVProgressHUD dismiss];
                                               NSLog(@"Error Creating token\nLocalized error: %@\nBusiness Error: %@", error.localizedDescription, businessError.merchantMessage);
                                           }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SourceSeletionSID"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        navigationController.modalPresentationStyle = UIModalPresentationPopover;
        navigationController.popoverPresentationController.delegate = self;
        
        CLQSourceSelectionTableViewController *sourceSelectionTableViewController = (CLQSourceSelectionTableViewController *)navigationController.topViewController;
        [sourceSelectionTableViewController setDelegate:self];
    }
}

@end
