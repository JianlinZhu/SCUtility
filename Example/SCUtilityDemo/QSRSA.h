//
// Created by sqiu on 15/3/11.
// Copyright (c) 2015 QS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QSRSA : NSObject


@property(nonatomic) int padding;

- (void)setPublicKey:(NSString *)publicKey;

- (void)setPrivateKey:(NSString *)privateKey;

- (NSData *)encryptDataWithPublicKey:(NSData *)data;

- (NSData *)encryptDataWithPrivateKey:(NSData *)data;

- (NSData *)decryptDataWithPublicKey:(NSData *)data;

- (NSData *)decryptDataWithPrivateKey:(NSData *)data;
@end