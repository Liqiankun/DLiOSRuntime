//
//  NSObject+Model.m
//  DLiOSRuntime
//
//  Created by David on 2018/11/3.
//  Copyright © 2018 David. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Model)

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        for (NSString *key in dictionary.allKeys) {
            id value = dictionary[key];
            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }
    return self;
}

- (NSDictionary *)covertToDictionary {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    if (count != 0) {
        NSMutableDictionary *resultDict = [@{} mutableCopy];
        
        for (NSUInteger i = 0; i < count; i ++) {
            const void *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL getter = [self propertyGetterByKey:name];
            if (getter) {
                id value = ((id (*)(id, SEL))objc_msgSend)(self, getter);
                if (value) {
                    resultDict[name] = value;
                } else {
                    resultDict[name] = @"字典的key对应的value不能为nil哦！";
                }
            }
        }
        
        free(properties);
        
        return resultDict;
    }
    
    free(properties);
    
    return nil;
}

- (SEL)propertySetterByKey:(NSString *)key
{
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
    NSLog(@"pro %@", propertySetterName);
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

- (SEL)propertyGetterByKey:(NSString *)key
{
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}

@end
