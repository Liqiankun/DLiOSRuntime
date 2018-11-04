//
//  Brid.m
//  DLiOSRuntime
//
//  Created by David on 2018/11/4.
//  Copyright © 2018 David. All rights reserved.
//

#import "Bird.h"
#import "People.h"

@implementation Bird

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍老师";
    [anInvocation invokeWithTarget:cangTeacher];
}


@end
