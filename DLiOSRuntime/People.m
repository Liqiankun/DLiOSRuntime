//
//  People.m
//  DLRuntimeDemo
//
//  Created by David on 2018/11/2.
//  Copyright © 2018 David. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
#import <objc/message.h>

void otherSing(id self, SEL cmd)
{
    NSLog(@"%@ 唱歌啦！",((People *)self).name);
}


@implementation People

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"sing"]) {
        class_addMethod(self, sel, (IMP)otherSing, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
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
    [anInvocation setSelector:@selector(dance)];
    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"消息无法处理：%@", NSStringFromSelector(aSelector));
}

- (void)dance
{
    NSLog(@"跳舞！！！come on！");
}

- (NSDictionary *)allProperties {
    unsigned int count = 0;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (int i = 0;  i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        if (propertyValue) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"no value for this key";
        }
    }
    return resultDict;
}

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    for (int i = 0;  i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        id varValue = [self valueForKey:name];
        if (varValue) {
            resultDict[name] = varValue;
        } else {
            resultDict[name] = @"no value for this key";
        }
    }
    return resultDict;
}

- (NSDictionary *)allMethods
{
    unsigned int count = 0;
    
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    Method *methods = class_copyMethodList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i ++) {
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        int arguments = method_getNumberOfArguments(methods[i]);
        resultDict[name] = @(arguments-2);
    }
    
    free(methods);
    
    return resultDict;
}

@end
