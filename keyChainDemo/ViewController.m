//
//  ViewController.m
//  keyChainDemo
//
//  Created by Henry on 2017/3/3.
//  Copyright © 2017年 无届网络科技. All rights reserved.

#import "ViewController.h"
#import "MXKeyChain.h"
static NSString *const UUIDKEY = @"UUIDKEY";
@interface ViewController ()
- (IBAction)loadUUID;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadUUID];
}

//每次卸载应用重装加载的UUID都不会变，但重置系统后就没有数据了。
- (IBAction)loadUUID {
    
    NSString *uuidStr = [MXKeyChain keyChainLoadStringWithSecureKey:UUIDKEY];
    
    if (!uuidStr.length){
        
        uuidStr = [[NSUUID UUID] UUIDString];//此方法每次加载的UUID都不一样
        
        [MXKeyChain keyChainSaveString:uuidStr WithSecureKey:UUIDKEY];
    
    }

    NSLog(@"UUID: %@",uuidStr);
}

@end
