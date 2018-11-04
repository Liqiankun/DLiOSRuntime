//
//  People.h
//  DLRuntimeDemo
//
//  Created by David on 2018/11/2.
//  Copyright © 2018 David. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject
{
    NSString *_occupation;
    NSString *_nationality;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

- (void)sing;

@end

NS_ASSUME_NONNULL_END
