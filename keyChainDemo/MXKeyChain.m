//
//  MXKeyChain.m
//  keyChainDemo
//
//  Created by Henry on 2017/3/4.
//  Copyright © 2017年 无届网络科技. All rights reserved.
//

#import "MXKeyChain.h"

@implementation MXKeyChain

+ (void)keyChainSaveString:(NSString *)string WithSecureKey:(NSString *)secureKey {
    
    [self saveData:string withSecureKey:secureKey];
}

+ (NSString *)keyChainLoadStringWithSecureKey:(NSString *)secureKey{
    
    return (NSString *)[self loadDataWithSecureKey:secureKey];
    
}

+ (void)keyChainDeleteStringWithSecureKey:(NSString *)secureKey{
    
    [self deleteDataWithSecureKey:secureKey];
}

#pragma mark- privateMethod
+ (void)saveData:(id)data withSecureKey:(NSString *)secureKey  {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:secureKey];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)loadDataWithSecureKey:(NSString *)secureKey {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:secureKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", secureKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteDataWithSecureKey:(NSString *)secureKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:secureKey];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)secureKey {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            secureKey, (id)kSecAttrService,
            secureKey, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

@end
