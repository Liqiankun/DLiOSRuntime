//
//  NSObject+Model.h
//  DLiOSRuntime
//
//  Created by David on 2018/11/3.
//  Copyright © 2018 David. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)covertToDictionary;

@end

NS_ASSUME_NONNULL_END
