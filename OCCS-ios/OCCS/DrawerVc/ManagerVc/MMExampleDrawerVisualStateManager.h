

#import <Foundation/Foundation.h>
#import "MMDrawerVisualState.h"


/**
 *  四种动画
 */
typedef NS_ENUM(NSInteger, MMDrawerAnimationType)
{
    /**
     *  无动画
     */
    MMDrawerAnimationTypeNone,
    /**
     *  幻灯片
     */
    MMDrawerAnimationTypeSlide,
    /**
     *  变小和幻灯片
     */
    MMDrawerAnimationTypeSlideAndScale,
    /**
     *   盒子
     */
    MMDrawerAnimationTypeSwingingDoor,
    /**
     *   随着动
     */
    MMDrawerAnimationTypeParallax,
};

@interface MMExampleDrawerVisualStateManager : NSObject

@property (nonatomic,assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic,assign) MMDrawerAnimationType rightDrawerAnimationType;

+ (MMExampleDrawerVisualStateManager *)sharedManager;

-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;

@end
