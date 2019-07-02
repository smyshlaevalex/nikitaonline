//
//  ItemPosition.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemPosition : NSObject

@property(nonatomic) NSString *type;
@property(nonatomic) NSUInteger positionIndex;
@property(nonatomic) CGPoint position;
@property(nonatomic) NSString *imageName;

- (instancetype)initWithType:(NSString *)type
               positionIndex:(NSUInteger)positionIndex
                    position:(CGPoint)position
                   imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
