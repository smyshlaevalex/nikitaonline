//
//  Item.m
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithType:(NSString *)type
           possiblePositions:(NSArray<ItemPosition *> *)possiblePositions {
    self = [super init];
    if (self) {
        _type = type;
        _possiblePositions = possiblePositions;
    }
    return self;
}

- (ItemPosition *)randomizedPosition {
    NSUInteger randomNumber = (NSUInteger)arc4random_uniform((uint32_t)self.possiblePositions.count);
    
    return self.possiblePositions[randomNumber];
}

@end
