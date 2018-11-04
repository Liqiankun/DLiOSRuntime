//
//  ViewController.m
//  DLiOSRuntime
//
//  Created by David on 2018/11/3.
//  Copyright © 2018 David. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "People.h"
#import "People+Associated.h"
#import "NSObject+Model.h"
#import "Bird.h"

@interface ViewController ()

@end

void sayFunction(id self, SEL _cmd, id some) {
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"name"],some);
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createClassAndSendMessage];
    
//    [self logPeople];
    
//    [self logPeopleWithCategory];
    
//    [self createPeopleWithDictionary];
    
//    [self bridSingSong];
    
    [self peopleDance];
    
}


- (void)createClassAndSendMessage {
    Class People = objc_allocateClassPair([NSObject class], "Person", 0);
    
    class_addIvar(People, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
    
    SEL s = sel_registerName("say:");
    class_addMethod(People, s, (IMP)sayFunction, "v@:@");
    
    objc_registerClassPair(People);
    
    id peopleInstance = [[People alloc] init];
    
    [peopleInstance setValue:@"David" forKey:@"name"];
    Ivar ageIvar = class_getInstanceVariable(People, "_age");
    object_setIvar(peopleInstance, ageIvar, @(18));
    
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
    
    peopleInstance = nil;
    objc_disposeClassPair(People);
}

- (void)logPeople {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    [cangTeacher setValue:@"老师" forKey:@"occupation"];
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *ivarResultDic = [cangTeacher allIvars];
    for (NSString *ivarName in ivarResultDic.allKeys) {
        NSLog(@"ivarName:%@, ivarValue:%@",ivarName, ivarResultDic[ivarName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
    }
}

- (void)logPeopleWithCategory {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    [cangTeacher setValue:@"老师" forKey:@"occupation"];
    cangTeacher.associatedBust = @(90);
    cangTeacher.associatedCallBack = ^(){
        NSLog(@"苍老师要写代码了！");
    };
    cangTeacher.associatedCallBack();
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
    }

}


- (void)createPeopleWithDictionary {
    NSDictionary *dictionary = @{
                                 @"name": @"苍老师"
                                 };
    
    People *cangTeacher = [[People alloc] initWithDictionary:dictionary];
    
    NSLog(@"cangTeacher's name %@", cangTeacher.name);
    
    if ([cangTeacher respondsToSelector:@selector(covertToDictionary)]) {
         NSLog(@"mode to dic %@", [cangTeacher covertToDictionary]);
    }
    
    [cangTeacher sing];

}


- (void)bridSingSong {
    Bird *bird = [[Bird alloc] init];
    bird.name = @"小小鸟";
    
    ((void (*)(id, SEL))objc_msgSend)((id)bird, @selector(sing));
}


- (void)peopleDance {
    People *cangTeacher = [[People alloc] init];
    ((void(*)(id, SEL)) objc_msgSend)((id)cangTeacher, @selector(sing));
}
@end
