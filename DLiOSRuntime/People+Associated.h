//
//  People+Associated.h
//  DLiOSRuntime
//
//  Created by David on 2018/11/3.
//  Copyright © 2018 David. All rights reserved.
//

#import "People.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CodingCallBack)(void);

@interface People (Associated)

@property (nonatomic, strong) NSNumber *associatedBust;
@property (nonatomic, copy) CodingCallBack associatedCallBack;

@end

NS_ASSUME_NONNULL_END
