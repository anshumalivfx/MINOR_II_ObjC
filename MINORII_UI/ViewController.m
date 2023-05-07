//
//  ViewController.m
//  MINORII_UI
//
//  Created by Anshumali Karna on 07/05/23.
//

#include "ViewController.h"
#include "NSObject+URLManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSVisualEffectView *blurView = [[NSVisualEffectView alloc] initWithFrame:self.view.bounds];
    blurView.material = NSVisualEffectMaterialDark;
    blurView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    blurView.alphaValue = 0.9;
    
    [self.view addSubview:blurView positioned:NSWindowBelow relativeTo:nil];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)showMoreButton:(id)sender {
    [self performSegueWithIdentifier:@"showmain" sender:self];
}

- (IBAction)predictButton:(NSButton *)sender {
    double ehLevel = [_ehLevelTextField doubleValue];
    
    URLManager *urlManager = [[URLManager alloc] init];
    
    [urlManager requestData:ehLevel completionHandler:^(NSDictionary * responseDict, NSError * error) {
        if (error) {
                // handle error
            NSAlert *alert = [[NSAlert alloc] init];
            
            [alert setAlertStyle:NSAlertStyleCritical];
            [alert setMessageText:[error localizedDescription]];
            
            [self presentError:error];
            
            NSLog(@"%@", [error localizedDescription]);
                return;
            }
        
        NSNumber *prediction = responseDict[@"prediction"];
        NSNumber *confidence = responseDict[@"confidence"];
        
        NSString *result;
        
        
        NSString *confidenceFinal = [NSString stringWithFormat:@"%.2f%%", [confidence doubleValue] * 100];
        
        if ([prediction  isEqual: @0]) {
            result = @"Safe";
        }
        else if ([prediction  isEqual: @1]){
            result = @"Unsafe";
        }
        
        NSLog(@"%@", result);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_resultsLabel.stringValue = [NSString stringWithFormat:@"Predictions:- \n \n Result: %@ \n Confidence Level:- %@", result, confidenceFinal];
        });
        
    
        
        
    }];
    
}
@end
