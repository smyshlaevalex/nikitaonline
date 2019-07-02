#import "MainScene.h"

#import "AspectFitView.h"
#import "ZoomingView.h"
#import "ConfigXMLDecoder.h"
#import "Config.h"
#import "Item.h"
#import "ItemPosition.h"

static const CGSize MAIN_SCENE_SIZE = (CGSize){720, 640};

@implementation MainScene

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupScene];
    }
    return self;
}

#pragma mark - Private

- (void)setupScene {
    NSURL *configURL = [NSBundle.mainBundle URLForResource:@"config" withExtension:@"xml"];
    ConfigXMLDecoder *decoder = [[ConfigXMLDecoder alloc] initWithURL:configURL];
    Config *config = [decoder parsedConfig];
    
    CCSprite *backgroundSprite = [CCSprite spriteWithImageNamed:config.backgroundImageName];
    backgroundSprite.anchorPoint = CGPointZero;
    
    AspectFitView *aspectFitView = [AspectFitView aspectFitViewWithContentNode:backgroundSprite
                                                                  originalSize:MAIN_SCENE_SIZE];
    
    CGSize viewSize = CCDirector.sharedDirector.viewSize;
    CGFloat widthDifference = MAIN_SCENE_SIZE.width - viewSize.width;
    CGFloat heightDifference = MAIN_SCENE_SIZE.height - viewSize.height;
    
    CGFloat minimumZoomScale;
    if (widthDifference > heightDifference) {
        minimumZoomScale = viewSize.width / MAIN_SCENE_SIZE.width;
    } else {
        minimumZoomScale = viewSize.height / MAIN_SCENE_SIZE.height;
    }
    
    aspectFitView.zoomScale = minimumZoomScale;
    
    ZoomingView *zoomingView = [ZoomingView zoomingViewWithAspectFitView:aspectFitView];
    zoomingView.minimumZoomScale = minimumZoomScale;
    zoomingView.maximumZoomScale = minimumZoomScale * 1.3;
    zoomingView.centerContents = YES;
    zoomingView.containerSizeForCentering = viewSize;
    [self addChild:zoomingView];
    
    for (Item *item in config.items) {
        [self addItem:item toBackgroundNode:backgroundSprite];
    }
}

- (void)addItem:(Item *)item toBackgroundNode:(CCNode *)backgroundNode {
    ItemPosition *itemPosition = [item randomizedPosition];
    
    CCSprite *itemSprite = [CCSprite spriteWithImageNamed:itemPosition.imageName];
    itemSprite.anchorPoint = CGPointMake(0, 1);
    itemSprite.position = CGPointMake(itemPosition.position.x, MAIN_SCENE_SIZE.height - itemPosition.position.y);
    [backgroundNode addChild:itemSprite];
}

@end
