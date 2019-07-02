//
//  ConfigXMLDecoder.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Config;

NS_ASSUME_NONNULL_BEGIN

@interface ConfigXMLDecoder : NSObject <NSXMLParserDelegate>

- (instancetype)initWithURL:(NSURL *)url;

-(Config *)parsedConfig;

@end

NS_ASSUME_NONNULL_END
