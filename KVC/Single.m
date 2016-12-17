//
//  Single.m
//  KVC
//
//  Created by 隆大佶 on 2016/12/17.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "Single.h"


@implementation Single
static Single *shareSingleton = nil;

+( instancetype ) sharedSingleton{
    
    static dispatch_once_t onceToken;
    
    dispatch_once ( &onceToken, ^ {
        
     shareSingleton = [[   Single allocWithZone:nil]init] ;
        
    } );
    
    return shareSingleton;
    
}


+(id) allocWithZone:(struct _NSZone *)zone {
    
    return [Single sharedSingleton] ;

}

-(id) copyWithZone:(struct _NSZone *)zone {
    
    return [Single sharedSingleton] ;
    
}



@end
