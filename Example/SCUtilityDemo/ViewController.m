//
//  ViewController.m
//  SCUtilityDemo
//
//  Created by Jarry on 15/5/5.
//  Copyright (c) 2015年 iChint. All rights reserved.
//

#import "ViewController.h"
#import "SCUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *base64Test = @"Man";
//    NSString *base64Encoded = [base64Test base64EncodedString];
//    NSString *decoded = [base64Encoded base64DecodedString];
    
    
//    NSString *test = [@"123456" MD5String];
//    NSLog(@"md5:\n%@", test);
//    [self rsaEncryptData:[test dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) test
{
    NSString *test = @"nLmzCd+mkYfqKpqKx50nOlhMPhCNiGzUeGp3/3agACRSAWKKUBSIJfmvoIVJwWaYePlIaZGZ/ex4m23IIiC/4Q+LriLVTRYgBOebKbRuTd43f9Bgixste3lLh6cg7v5X08AwpgjauFgbbpAcuWrULcmqnxRgv8wj4c/+SOKtiKM=";
    NSLog(@"\n%@", [test base64DecodedString]);
    
//    NSString *test1 = [@"123456" MD5String];
//    NSLog(@"md5:\n%@", test1);
//    NSString *test = [self rsaEncryptData:[test1 dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self rsaDecryptString:test];
//    [self rsaDecryptData:[test dataUsingEncoding:NSUTF8StringEncoding]];
    
    return;
    
    /*
    NSString *serverEncryptString = @"JRG8A3P5slLmANNKWjzAvPSfZfiZJCkVBgDvEty9CFkF3UCSAompqcpyHEQlt/C/GzvROY4aiYE4E8l06Q5w0qeAmc1pJCDhYdf1GNA2l1ok7hAsgLsTko6MmGGUnRfsb+j9kxPVBrK9zPqFiYcMV+zwULeD2catngHDlT3sBQk=";

    
    
    //Public key 1024
    //Plain Text
    NSData *plainData = [test dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *publicKey = @"-----BEGIN PUBLIC KEY-----\n"
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCzQiJquVvgZXdMM7OtiXg1sGnR\n"
    "hm1VxePem/MCMI1vh5RxqtriKjZjk7IRNBIhuzCgdqT6+REDUBDb6UM31DJXZGSe\n"
    "bl2muYhJfhUeIs7ACLqHsMtLlWqCRtfZZc4WAU157t/PMEHsjGG8nOqoXkYCZfx2\n"
    "/oI1jiSLpctY96ONewIDAQAB\n"
    "-----END PUBLIC KEY-----";
    
    NSString *publicKey1 = @"-----BEGIN PUBLIC KEY-----\n"
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC36uOYiF/v3Jk5JLeRNW79wvr4C8kaYg8FxIP9\n"
    "I/id9byyHk7wws9humNlrs8YisbtkO8YONOyOYeaNVELJDrATIFoNa8i9vldujn9kc5IvjHUjsas\n"
    "xox1IB5BLn6KnAenP+0eOeMeY3nbE74YyT5jEXsGKmGyL4QNBlgJys92CwIDAQAB\n"
    "-----END PUBLIC KEY-----";*/
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    NSMutableString *publicKey = [NSMutableString string];
    [publicKey appendString:@"-----BEGIN PUBLIC KEY-----\n"];
    NSString *base64Key = [publicKeyFileContent base64EncodedStringWithOptions:0];
    [publicKey appendString:base64Key];
    [publicKey appendString:@"\n-----END PUBLIC KEY-----"];

    
}

#pragma mark - Decrypt

- (SecKeyRef) getPublicKey
{
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    if (publicKeyPath == nil) {
        NSLog(@"Can not find pub.der");
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        NSLog(@"Can not read from pub.der");
        return nil;
    }
    
    SecCertificateRef certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        NSLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    SecTrustRef trust;
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        NSLog(@"SecTrustCreateWithCertificates fail. Error Code: %d", returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        NSLog(@"SecTrustEvaluate fail. Error Code: %d", returnCode);
        return nil;
    }
    
    SecKeyRef publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        NSLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    
    CFRelease(certificate);
    CFRelease(policy);
    CFRelease(trust);

    return publicKey;
}

-(NSString*) rsaDecryptString:(NSString*)string
{
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:string options:0];
    NSData* decryptData = [self rsaDecryptData:nsdataFromBase64String];
    NSString* result = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData*) rsaDecryptData:(NSData*)data
{
//    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC36uOYiF/v3Jk5JLeRNW79wvr4C8kaYg8FxIP9I/id9byyHk7wws9humNlrs8YisbtkO8YONOyOYeaNVELJDrATIFoNa8i9vldujn9kc5IvjHUjsasxox1IB5BLn6KnAenP+0eOeMeY3nbE74YyT5jEXsGKmGyL4QNBlgJys92CwIDAQAB";
    
    SecKeyRef publicKey = [self getPublicKey];
    
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    size_t plainTextLen = SecKeyGetBlockSize(publicKey) - 12;
    
    NSMutableData *plainText = [NSMutableData dataWithLength:plainTextLen];
    OSStatus status = SecKeyDecrypt(publicKey, kSecPaddingPKCS1, (const uint8_t *) [data bytes], cipherBufferSize, [plainText mutableBytes], &plainTextLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plainText length:plainTextLen];
    
    return decryptedData;
}

- (NSString*) rsaEncryptData:(NSData*)data
{
    SecKeyRef publicKey = [self getPublicKey];

    size_t maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    
    size_t plainLen = [data length];
    if (plainLen > maxPlainLen) {
        NSLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }
    
    void *plain = malloc(plainLen);
    [data getBytes:plain length:plainLen];
    
    size_t cipherLen = 128; // 当前RSA的密钥长度是128字节
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);
    
    NSString *result = nil;
    if (returnCode != 0) {
        NSLog(@"SecKeyEncrypt fail. Error Code: %d", returnCode);
    }
    else {
        result = [[NSData dataWithBytes:cipher
                                length:cipherLen] base64EncodedStringWithOptions:0];
    }
    
    free(plain);
    free(cipher);
    
    NSLog(@"\n%@", result);
    
    return result;
}

@end
