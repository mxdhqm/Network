//
//  HttpWrapper.m
//  Network
//
//  Created by metthew on 15/5/6.
//  Copyright (c) 2015年 metthew. All rights reserved.
//

#import "HTTPWrapper.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "AppDelegate.h"


@interface HTTPWrapper()

@end

@implementation HTTPWrapper

- (AFHTTPRequestOperation *)post:(NSString *)url
                        reqParms:(NSMutableDictionary *)dict
                     encryptFlag:(BOOL)encryptFlag
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self post:url reqParms:dict encryptFlag:encryptFlag httpsFlag:NO success:success failure:failure];
}

- (AFHTTPRequestOperation *)httpsPost:(NSString *)url
                             reqParms:(NSMutableDictionary *)dict
                          encryptFlag:(BOOL)encryptFlag
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self post:url reqParms:dict encryptFlag:encryptFlag httpsFlag:YES success:success failure:failure];
}

//异步方式提交请求
- (AFHTTPRequestOperation *)post:(NSString *)url reqParms:(NSMutableDictionary *)dict encryptFlag:(BOOL)encryptFlag httpsFlag:(BOOL)httpsFlag success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{

    NSString *reqUrl = url;
    
    if (!dict)
        dict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *params = dict;
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (httpsFlag) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
    }
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    AFHTTPRequestOperation *operation = [manager POST:reqUrl parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 if (success)
                     success(operation, responseObject);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure)
                 failure(operation, error);
         }];

    return operation;
}

- (AFHTTPRequestOperation *)post:(NSString *)url
                        reqParms:(NSMutableDictionary *)dict
                     encryptFlag:(BOOL)encryptFlag
                         isAlert:(BOOL)isAlert
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *reqUrl = url;
    
    if (!dict)
        dict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *params = dict;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    AFHTTPRequestOperation *operation = [manager POST:reqUrl parameters:params
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      if (success)
                                                          success(operation, responseObject);
                                                  
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  if (isAlert) {
//                                                      [self showFailedMessage:error];
                                                  }
                                                  if (failure)
                                                      failure(operation, error);
                                              }];
    
    return operation;
}

- (AFHTTPRequestOperation *)setChannel:(NSString *)url
                        reqParms:(NSMutableDictionary *)dict
                     encryptFlag:(BOOL)encryptFlag
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *reqUrl = url;
    
    if (!dict)
        dict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *params = dict;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    AFHTTPRequestOperation *operation = [manager POST:reqUrl parameters:params
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  NSDictionary *resp = (NSDictionary*)responseObject;
                                                  long result = ((NSNumber*)[resp objectForKey:@"result"]).longValue;
                                                  
                                                  NSError *error ;
                                                  
                                                  if (error){
                                                      if (failure)
                                                          failure(operation, error);
                                                  }else{
                                                      if (success)
                                                          success(operation, responseObject);
                                                  }
                                                  
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  if (failure)
                                                      failure(operation, error);
                                              }];
    
    return operation;
}

//异步方式提交HTTP请求
- (AFHTTPRequestOperation *)get:(NSString *)url
                        reqParms:(NSMutableDictionary *)dict
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *reqUrl = url;
    if (!dict)
        dict = [[NSMutableDictionary alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    AFHTTPRequestOperation *operation = [manager GET:reqUrl parameters:dict
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     if (success)
                                                         success(operation, responseObject);
                                                 
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                 [self showFailedMessage:error];
                                                 if (failure)
                                                     failure(operation, error);
                                             }];
    
    return operation;
}

- (AFHTTPRequestOperationManager *)XMLDataWithUrl:(NSString *)url
              reqParms:(NSMutableDictionary *)dict
           encryptFlag:(BOOL)encryptFlag
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSString *reqUrl = url;
    
    NSMutableDictionary *params = dict;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 返回的数据格式是XML
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:reqUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self showFailedMessage:error];
        if (failure) {
            failure(operation, error);
        }
    }];
    return manager;
}

#pragma mark -- 带进度条下载
- (void)methodDownload:(NSString *)url
                      showView:(UIView *)view
                 bytesReadView:(UILabel *) bytesReadView
            totalBytesReadView:(UILabel *) totalBytesReadView
                      progress:(UIProgressView *)downProgress
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSString* downloadFilePath))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    //[view addSubview:downProgress];
    
    //NSURL *urlstr = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
     NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self createDir:@"temp" dirPath:2],[url lastPathComponent]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];

    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //当前一次读取的字节数   bytesRead
        //已经下载的字节数      totalBytesRead
        //文件总大小           totalBytesExpectedToRead
        
        bytesReadView.text = [NSString stringWithFormat:@"%.1f %@",(((float)totalBytesRead) / totalBytesExpectedToRead)*100,@"%"];
        totalBytesReadView.text = [NSString stringWithFormat:@"%@/%@",[self formatByteCount:totalBytesRead],[self formatByteCount:totalBytesExpectedToRead]];
        CGFloat progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
        [downProgress setProgress:progress animated:YES];
    
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        success(operation, responseObject, filePath);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    
    [operation start];
}



- (void)methodDownload:(NSString *)url
     downLoadOperation:(AFHTTPRequestOperation *)downLoadOperation
         bytesReadView:(UILabel*) bytesReadView
    totalBytesReadView:(UILabel*) totalBytesReadView
              progress:(UIProgressView *)downProgress
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSString* downloadFilePath))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    //[view addSubview:downProgress];
    
    //NSURL *urlstr = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self createDir:@"temp" dirPath:2],[url lastPathComponent]];
    downLoadOperation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    [downLoadOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //当前一次读取的字节数   bytesRead
        //已经下载的字节数      totalBytesRead
        //文件总大小           totalBytesExpectedToRead
        
        bytesReadView.text = [NSString stringWithFormat:@"%.1f %@",(((float)totalBytesRead) / totalBytesExpectedToRead)*100,@"%"];

        totalBytesReadView.text = [NSString stringWithFormat:@" 下载课件 (%@/%@)",[self formatByteCount:totalBytesRead],[self formatByteCount:totalBytesExpectedToRead]];
        CGFloat progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
        [downProgress setProgress:progress animated:YES];
    }];
    [downLoadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject, filePath);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    
    [downLoadOperation start];
}

- (void)methodDownload:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSString* downloadFilePath))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self methodDownload:url showView:nil bytesReadView:nil totalBytesReadView:nil progress:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSString *downloadFilePath) {
        success(operation,responseObject,downloadFilePath);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (NSArray *)sortWithList:(NSArray *)array
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSString *str in array) {
        NSString *key = [[[[str componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject];
        [dic setObject:str forKey:key];
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        NSString *_kye = [NSString stringWithFormat:@"%d",i];
        NSString *objc = [dic objectForKey:_kye];
        [arr addObject:objc];
    }
    return arr;
}

- (NSString *)formatByteCount:(long long)size{
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

#pragma mark - 文件上传 自己定义文件名
- (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    
    NSString *reqUrl = urlStr;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:reqUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:fileTye error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail();
        }
    }];
}

#pragma mark - POST上传文件
- (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    NSString *reqUrl = urlStr;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:reqUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                success(str);
            }else{
                success(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }
    }];
}

- (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL reqParms:(NSMutableDictionary *)dict success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    NSMutableDictionary *params = dict;
//    [self addToken:dict];

    NSString *reqUrl = urlStr;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:reqUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                success(str);
            }else{
                success(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }
    }];
}

-(void)uploadURL:(NSString *)url andImageToPost:(UIImage *)imageToPost andParams:(NSMutableDictionary *) params completionHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error)) handler{
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
//    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    
//    url = [NSString stringWithFormat:@"%@%@?token=%@",[self getServerHost] , url, [[GlobalHelper instance] token]];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:url];
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant, [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"jpg"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
    
}

+ (BOOL)isNetWorkError:(NSError *)error{
    if (error.code == NSURLErrorNotConnectedToInternet)
        return YES;
    else if (error.code == NSURLErrorCannotConnectToHost)
        return YES;
    else if (error.code == NSURLErrorTimedOut)
        return YES;
    else if (error.code == NSURLErrorCannotFindHost)
        return YES;
    else if (error.code == NSURLErrorCallIsActive)
        return YES;
    else if (error.code == NSURLErrorNetworkConnectionLost)
        return YES;
    else if (error.code == NSURLErrorDataNotAllowed)
        return YES;
    else
        return NO;
}


-(NSString *) createDir:(NSString *)dirName dirPath:(NSInteger)dirPath{
    NSString *dir = nil;
    if (dirPath == 1) {
        NSArray *docuPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        dir = [docuPaths objectAtIndex:0];
    }
    if (dirPath == 2) {
        NSArray *docuPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        dir = [docuPaths objectAtIndex:0];
    }
    if (dirPath ==3) {
        dir = NSTemporaryDirectory();
    }
    
    NSString *fileDir = [NSString stringWithFormat:@"%@/%@",dir, dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ){
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fileDir;
}


@end
