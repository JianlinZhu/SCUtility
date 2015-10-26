//
// Created by sqiu on 15/3/11.
// Copyright (c) 2015 QS. All rights reserved.
//

#import "QSRSA.h"
#import "rsa.h"
#import "pem.h"


@implementation QSRSA {
    NSString *_publicKey;
    NSString *_privateKey;
    RSA *_publicKeyRSA;
    RSA *_privateKeyRSA;
}

- (id)init {
    self = [super init];
    if (self) {
        self.padding = RSA_X931_PADDING;
    }
    return self;
}

- (void)setPublicKey:(NSString *)publicKey {
    _publicKey = publicKey;
    
    const char *key = [publicKey UTF8String];
    BIO *bio = BIO_new_mem_buf((void *) key, (int) strlen(key));
    _publicKeyRSA = PEM_read_bio_RSA_PUBKEY(bio, NULL, 0, NULL);
    BIO_free(bio);
    
}

- (void)setPrivateKey:(NSString *)privateKey {
    _privateKey = privateKey;
    
    const char *key = [privateKey UTF8String];
    BIO *bio = BIO_new_mem_buf((void *) key, (int) strlen(key));
    _privateKeyRSA = PEM_read_bio_RSAPrivateKey(bio, NULL, 0, NULL);
    BIO_free(bio);
}

- (NSData *)encryptDataWithPublicKey:(NSData *)data {
    int maxSize = RSA_size(_publicKeyRSA);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    self.padding = RSA_PKCS1_PADDING;
    int bytes = RSA_public_encrypt([data length], [data bytes], output, _publicKeyRSA, _padding);
    return (bytes > 0) ? [NSData dataWithBytes:output length:(NSUInteger) bytes] : nil;
}

- (NSData *)encryptDataWithPrivateKey:(NSData *)data {
    int maxSize = RSA_size(_privateKeyRSA);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_private_encrypt([data length], [data bytes], output, _privateKeyRSA, _padding);
    return (bytes > 0) ? [NSData dataWithBytes:output length:(NSUInteger) bytes] : nil;
}

- (NSData *)decryptDataWithPublicKey:(NSData *)data {
    int maxSize = RSA_size(_publicKeyRSA);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_public_decrypt([data length], [data bytes], output, _publicKeyRSA, _padding);
    return (bytes > 0) ? [NSData dataWithBytes:output length:(NSUInteger) bytes] : nil;
}

- (NSData *)decryptDataWithPrivateKey:(NSData *)data {
    int maxSize = RSA_size(_privateKeyRSA);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_private_decrypt([data length], [data bytes], output, _privateKeyRSA, _padding);
    return (bytes > 0) ? [NSData dataWithBytes:output length:(NSUInteger) bytes] : nil;
}
@end