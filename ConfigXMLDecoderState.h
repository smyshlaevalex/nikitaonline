//
//  ConfigXMLDecoderState.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConfigXMLDecoderState) {
    ConfigXMLDecoderStateNone,
    ConfigXMLDecoderStateInRoom,
    ConfigXMLDecoderStateInBackground,
    ConfigXMLDecoderStateInItems,
    ConfigXMLDecoderStateInItem
};
