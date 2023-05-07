//
//  NSObject+URLManager.m
//  MINORII_UI
//
//  Created by Anshumali Karna on 07/05/23.
//

#import "NSObject+URLManager.h"

@implementation URLManager: NSObject
- (void)requestData:(double)Eh completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5000/predict"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"POST"];

    NSDictionary *bodyDict = @{@"Eh": [NSNumber numberWithDouble:Eh]};
    NSError *error;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&error];
    [request setHTTPBody:bodyData];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            completionHandler(nil, error);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError) {
            NSLog(@"Error parsing response JSON: %@", jsonError.localizedDescription);
            completionHandler(nil, jsonError);
            return;
        }
        
        NSNumber *prediction = responseDict[@"prediction"];
        NSNumber *confidence = responseDict[@"confidence"];
        
        NSLog(@"Prediction: %@, Confidence: %@", prediction, confidence);
        
        completionHandler(responseDict, nil);
    }];

    [task resume];
}

@end
