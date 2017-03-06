//
//  MXKeyChain.h
//  keyChainDemo
//
//  Created by Henry on 2017/3/4.
//  Copyright © 2017年 无届网络科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
@interface MXKeyChain : NSObject

/**
 *  存储字符串到 KeyChain
 */
+ (void)keyChainSaveString:(NSString *)string WithSecureKey:(NSString *)secureKey;

/**
 *  从 KeyChain 中读取存储的字符串
 */
+ (NSString *)keyChainLoadStringWithSecureKey:(NSString *)secureKey;

/**
 *  删除 KeyChain 信息
 */
+ (void)keyChainDeleteStringWithSecureKey:(NSString *)secureKey;

@end
