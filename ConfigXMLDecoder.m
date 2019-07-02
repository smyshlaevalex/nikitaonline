//
//  ConfigXMLDecoder.m
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "ConfigXMLDecoder.h"

#import "ConfigXMLDecoderState.h"

#import "Config.h"
#import "Item.h"
#import "ItemPosition.h"

@interface ConfigXMLDecoder ()

@property(nonatomic) NSXMLParser *xmlParser;
@property(nonatomic) ConfigXMLDecoderState state;

@property(nonatomic) NSString *backgroundImageName;
@property(nonatomic) NSMutableArray<ItemPosition *> *itemPositions;
@property(nonatomic) ItemPosition *currentParsingItemPosition;

@end

@implementation ConfigXMLDecoder

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        _xmlParser.delegate = self;
        
        _state = ConfigXMLDecoderStateNone;
        
        _itemPositions = [NSMutableArray array];
    }
    return self;
}

- (Config *)parsedConfig {
    [self.xmlParser parse];
    
    NSMutableArray<Item *> *items = [NSMutableArray array];
    NSString *currentType;
    NSMutableArray<ItemPosition *> *currentItemPositions = [NSMutableArray array];
    
    for (ItemPosition *itemPosition in self.itemPositions) {
        if (currentType) {
            if ([currentType isEqualToString:itemPosition.type]) {
                [currentItemPositions addObject:itemPosition];
            } else {
                Item *item = [[Item alloc] initWithType:currentType possiblePositions:[currentItemPositions copy]];
                [items addObject:item];
                
                [currentItemPositions removeAllObjects];
            }
        }
        
        currentType = itemPosition.type;
        [currentItemPositions addObject:itemPosition];
    }
    
    Item *item = [[Item alloc] initWithType:currentType possiblePositions:[currentItemPositions copy]];
    [items addObject:item];
    
    Config *config = [[Config alloc] initWithBackgroundImageName:self.backgroundImageName
                                                           items:[items copy]];
    return config;
}

- (NSString *)pathForResourse:(NSString *)resourseName {
    NSString *resourseFileName = [resourseName componentsSeparatedByString:@"/"][1];
    NSString *path = [NSBundle.mainBundle.resourcePath stringByAppendingString:[@"/" stringByAppendingString:resourseFileName]];
    
    return path;
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    switch (self.state) {
        case ConfigXMLDecoderStateNone:
            if ([elementName isEqualToString:@"room"]) {
                self.state = ConfigXMLDecoderStateInRoom;
            }
            
            break;
        case ConfigXMLDecoderStateInRoom:
            if ([elementName isEqualToString:@"background"]) {
                NSLog(@"Started parsing background");
                
                self.state = ConfigXMLDecoderStateInBackground;
            } else if ([elementName isEqualToString:@"items"]) {
                NSLog(@"Entered items");
                
                self.state = ConfigXMLDecoderStateInItems;
            }
            
            break;
        case ConfigXMLDecoderStateInItems:
            if ([elementName isEqualToString:@"item"]) {
                NSLog(@"Started parsing item");
                
                self.state = ConfigXMLDecoderStateInItem;
                
                NSString *type = attributeDict[@"type"];
                NSString *positionIndexString = attributeDict[@"position"];
                NSString *xString = attributeDict[@"x"];
                NSString *yString = attributeDict[@"y"];
                
                self.currentParsingItemPosition = [[ItemPosition alloc] initWithType:type
                                                                       positionIndex:positionIndexString.integerValue
                                                                            position:CGPointMake(xString.doubleValue, yString.doubleValue)
                                                                           imageName:@""];
            }
            
            break;
        default:
            break;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    switch (self.state) {
        case ConfigXMLDecoderStateInRoom:
            if ([elementName isEqualToString:@"room"]) {
                self.state = ConfigXMLDecoderStateNone;
            }
            
            break;
        case ConfigXMLDecoderStateInBackground:
            if ([elementName isEqualToString:@"background"]) {
                NSLog(@"Ended parsing background");
                
                self.state = ConfigXMLDecoderStateInRoom;
            }
            
            break;
        case ConfigXMLDecoderStateInItems:
            if ([elementName isEqualToString:@"items"]) {
                NSLog(@"Exited items");
                
                self.state = ConfigXMLDecoderStateInRoom;
            }
            
            break;
        case ConfigXMLDecoderStateInItem:
            if ([elementName isEqualToString:@"item"]) {
                NSLog(@"Ended parsing item");
                
                self.state = ConfigXMLDecoderStateInItems;
            }
            
            break;
        default:
            break;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    switch (self.state) {
        case ConfigXMLDecoderStateInBackground:
            NSLog(@"Parsed background: %@", string);
            
            self.backgroundImageName = [self pathForResourse:string];
            
            break;
        case ConfigXMLDecoderStateInItem:
            if (self.currentParsingItemPosition) {
                NSLog(@"Parsed item with image name: %@", string);
                
                self.currentParsingItemPosition.imageName = [self pathForResourse:string];
                [self.itemPositions addObject:self.currentParsingItemPosition];
                self.currentParsingItemPosition = nil;
            }
            
            break;
        default:
            break;
    }
}

@end
