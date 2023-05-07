//
//  NSObject+URLManager.h
//  MINORII_UI
//
//  Created by Anshumali Karna on 07/05/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URLManager: NSObject
- (void)requestData:(double)Eh completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler;
@end

NS_ASSUME_NONNULL_END
