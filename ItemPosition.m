//
//  ItemPosition.m
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "ItemPosition.h"

@implementation ItemPosition

- (instancetype)initWithType:(NSString *)type positionIndex:(NSUInteger)positionIndex position:(CGPoint)position imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _type = type;
        _positionIndex = positionIndex;
        _position = position;
        _imageName = imageName;
    }
    return self;
}

@end
