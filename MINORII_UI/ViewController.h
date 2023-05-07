//
//  ViewController.h
//  MINORII_UI
//
//  Created by Anshumali Karna on 07/05/23.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *ehLevelTextField;
@property (weak) IBOutlet NSTextField *resultsLabel;

- (IBAction)predictButton:(NSButton *)sender;
- (IBAction)showMoreButton:(id)sender;

@end

