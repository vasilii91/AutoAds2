//
//  KVNetworkManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KVNetworkManager.h"

static NSString *SERVER_URL_GET_FORMAT = @"http://%@/service/api/car/?v=1&action=%@&%@";
static NSString *SERVER_URL_POST_FORMAT = @"http://%@/service/api/car/?v=1&action=%@";

static KVNetworkManager *instance = nil;

@interface KVNetworkManager()

- (void)addRequest:(KVUrlRequest *)request;
- (void)removeRequest:(KVUrlRequest *)request;
- (BOOL)shouldPerformRequest:(int)type withId:(NSString *)identifier;
- (void)requestProcessed:(KVUrlRequest *)request;
- (void)requestFailed:(KVUrlRequest *)request error:(NSString *)message code:(int)code;

- (KVUrlRequest *)createMultipartFormRequest:(NSOutputStream*)outputStream url:(NSString*)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters withImages:(NSArray *)images;
- (KVUrlRequest *)requestToServer:(NSOutputStream *)outputStream url:(NSString *)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier jsonString:(NSString *)jsonString httpMethod:(NSString *)httpMethod;

+ (NSString*)getRequestKey:(int)type forId:(NSString *)identifier;
+ (NSString*)queryStringWithParams:(NSDictionary*)params;

@end


@implementation KVNetworkManager

#pragma mark -
#pragma mark Initialization

+ (KVNetworkManager *)sharedInstance 
{	
	if (instance == nil) {		
		instance = [NSAllocateObject([self class], 0, NULL) init];
	}
	
	return instance;
}

- (id)init 
{	
	self = [super init];
	
    if (self) {
        
        requests = [NSMutableDictionary new];
        subscribers = [NSMutableArray new];
	}
	
    return self;
}


#pragma mark -
#pragma mark Private methods

- (void)addRequest:(KVUrlRequest *)request
{    
    [requests setObject:request forKey:[KVNetworkManager getRequestKey:request.type forId:request.identifier]];
}

- (void)removeRequest:(KVUrlRequest *)request
{    
    // Request must not be released here. Put request into autoreleased pool for further release.
    [[request retain] autorelease];
    [requests removeObjectForKey:[KVNetworkManager getRequestKey:request.type forId:request.identifier]];
}

- (BOOL)shouldPerformRequest:(int)type withId:(NSString *)identifier 
{    
    if (![requests objectForKey:[KVNetworkManager getRequestKey:type forId:identifier]]) {
        
        return YES;
    }
    
    return NO;
}

- (void)requestProcessed:(KVUrlRequest *)request
{    
    for (NSObject<KVNetworkDelegate> *subscriber in subscribers) {
        
        [subscriber requestProcessed:request.type forId:request.identifier];
    }
}

- (void)requestFailed:(KVUrlRequest *)request error:(NSString *)message code:(int)code
{    
    for (NSObject<KVNetworkDelegate> *subscriber in subscribers) {
        
        [subscriber requestFailed:request.type forId:request.identifier error:message code:code];
    }
}

- (KVUrlRequest *)createMultipartFormRequest:(NSOutputStream*)outputStream url:(NSString*)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters withImages:(NSArray *)images
{
    static NSString* const BOUNDRY = @"6490653261771490969735433975";
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    NSMutableData *body = [[NSMutableData alloc] init];
    
    if ([images count] != 0) {
        for (UIImage *image in images) {
            NSData *imageData = UIImagePNGRepresentation(image);
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: attachment; name=\"Photo[]\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    for (NSString *key in [parameters allKeys]) {
        NSString *value = [parameters valueForKey:key];
        NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDRY] forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    
    NSString *s = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    NSLog(@"%@", s);
    [s release];
    
    [body release];
    
    KVUrlRequest *urlRequest = [[[KVUrlRequest alloc] initWithStream:outputStream request:request] autorelease];
    urlRequest.type = requestType;
    urlRequest.identifier = identifier;
    urlRequest.delegate = self;
    [urlRequest start];
    
    return urlRequest;
}

- (KVUrlRequest *)requestToServer:(NSOutputStream *)outputStream url:(NSString *)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier jsonString:(NSString *)jsonString httpMethod:(NSString *)httpMethod
{
    NSString *url = [NSString stringWithFormat:@"%@", [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod: httpMethod];
    
    NSLog(@"API req: %@", jsonString);
    NSData *body = nil;
    
    if (jsonString != nil) {
        body = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:body];
    }
    
    if ([httpMethod isEqualToString:@"POST"]) {
        NSString *postLength = [NSString stringWithFormat:@"%d",[body length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    }
    
    KVUrlRequest *urlRequest = [[[KVUrlRequest alloc] initWithStream:outputStream request:request] autorelease];
    urlRequest.type = requestType;
    urlRequest.identifier = identifier;
    urlRequest.delegate = self;
    [urlRequest start];
    
    return urlRequest;
}

+ (NSString*)queryStringWithParams:(NSDictionary*)params 
{    
    NSString *query = @""; 
    
    if (params != nil) {
        
        for (NSString *key in params) { 
            
            NSString *value = [params objectForKey:key];
            CFStringRef k = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)key, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8); 
            CFStringRef v = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)value, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8); 
            query = ([query length] > 0) ?[query stringByAppendingFormat:@"&%@=%@", (NSString *)k, (NSString *)v] : [NSString stringWithFormat:@"%@=%@", (NSString *)k, (NSString *)v]; 
            CFRelease(k); 
            CFRelease(v); 
        }
    }
    
    return query; 
}

+ (NSString*)getRequestKey:(int)type forId:(NSString *)identifier
{    
    return [NSString stringWithFormat:@"%@-%d", identifier, type];
}

- (NSString *)urlGetWithActionName:(NSString *)actionName parameters:(NSString *)parameters apiCall:(ApiCall)apiCall
{
    NSString *serverURL = [self serverURL];
    
    NSString *url = nil;
    if (apiCall == ApiCallGET) {
        url = [NSString stringWithFormat:SERVER_URL_GET_FORMAT, serverURL, actionName, parameters];
    }
    else {
        url = [NSString stringWithFormat:SERVER_URL_POST_FORMAT, serverURL, actionName];
    }
    
    return url;
}


#pragma mark -
#pragma mark Public methods

- (NSString *)serverURL
{
    NSString *currentNameOfGroup = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_NAME_OF_GROUP_OF_CITIES];
    NSString *serverURL = [AdvDictionaries valueFromDictionary:[AdvDictionaries HostLinks] forKeyOrValue:currentNameOfGroup];
    
    return serverURL;
}

- (void)subscribe:(NSObject<KVNetworkDelegate> *)subscriber
{    
    if (![subscribers containsObject:subscriber]) {
        
        [subscribers addObject:subscriber];
    }
}

- (void)unsubscribe:(NSObject<KVNetworkDelegate> *)subscriber
{    
    [subscribers removeObject:subscriber];
}


- (void)cancelRequest:(int)type forId:(NSString *)identifier 
{    
    NSString *key = [KVNetworkManager getRequestKey:type forId:identifier];
    KVUrlRequest *request = [requests objectForKey:key];
    
    if (request) {
        [request stop];
        [requests removeObjectForKey:key];
    }
}


#pragma mark -
#pragma mark Requests

- (void)connectToServerWithUsername:(NSString *)username password:(NSString *)password
{
//    NSString *jsonString = [NSString stringWithFormat:@"UserName=%@&Password=%@&RememberMe=false", username, password];
//    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:SERVER_URL_LOGIN requestType:RequestTypeLogin requestIdentifier:nil jsonString:jsonString httpMethod:@"POST"];
//    
//    [self addRequest:urlRequest];
//    
//    userName = username;
//    userPassword = password;
}

- (void)searchWithQuery:(NSString *)queryString
{
    NSString *url = [self urlGetWithActionName:@"Search" parameters:queryString apiCall:ApiCallGET];
    LOG(@"%@", url);
    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:url requestType:RequestTypeSearch requestIdentifier:@"" jsonString:nil httpMethod:@"GET"];
    
    [self addRequest:urlRequest];
}

- (void)getModelsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    NSString *jsonString = [NSString stringWithFormat:@"rubric=%@&subrubric=%@", rubric, subrubric];
    NSString *url = [self urlGetWithActionName:@"Brands" parameters:jsonString apiCall:ApiCallGET];
    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:url requestType:RequestTypeBrands requestIdentifier:@"" jsonString:nil httpMethod:@"GET"];
    
    [self addRequest:urlRequest];
}

- (void)savePhotosByPhotoContainer:(NSArray *)photoContainers
{
    NSMutableArray *photoURLs = [NSMutableArray new];
    for (PhotoContainer *photoContainer in photoContainers) {
        if (photoContainer.large.url != nil) {
            [photoURLs addObject: photoContainer.large.url];
        }
    }

    [FileManagerCoreMethods deleteDirectoryWithName:DEFAULT_PHOTOS_DIRECTORY_NAME];
    if ([photoURLs count] != 0) {
        [KVDataManager sharedInstance].countOfLoadedImages = 0;
        
        for (int i = 0; i < [photoURLs count]; i++) {
            NSString *photoURL = [photoURLs objectAtIndex:i];
            NSString *identifier = [NSString stringWithFormat:@"%d", i];
            KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:photoURL requestType:RequestTypePhotosOfCar requestIdentifier:identifier jsonString:nil httpMethod:@"GET"];
            
            [self addRequest:urlRequest];
        }
    }
    else {
        [self requestProcessed:nil];
    }
}

- (void)addAdvertisementWithParameters:(NSDictionary *)parameters images:(NSArray *)images
{
    NSString *url = [self urlGetWithActionName:@"AddAdvertisement" parameters:nil apiCall:ApiCallPOST];
    
    KVUrlRequest *urlRequest = [self createMultipartFormRequest:[NSOutputStream outputStreamToMemory] url:url requestType:RequestTypeAddAdvertisement requestIdentifier:@"" parameters:parameters withImages:images];
    [self addRequest:urlRequest];
}

- (void)getCaptcha
{
    NSString *serverURL = [self serverURL];
    NSString *captchaURL = [NSString stringWithFormat:@"http://www.%@/service/captcha/", serverURL];
    
    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:captchaURL requestType:RequestTypeGetCaptcha requestIdentifier:@"" jsonString:nil httpMethod:@"GET"];
    
    [self addRequest:urlRequest];
}

#pragma mark -
#pragma mark BAUrlRequestDelegate members

- (void)requestFailed:(KVUrlRequest*)request error:(NSError*)error
{
    [self requestFailed:request error:[error localizedDescription] code:FNApiErrorConnection];
    
    [self removeRequest:request];
}

- (void)requestSuccess:(KVUrlRequest*)request
{    
    [self removeRequest:request];
    
    [self requestProcessed:request];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{    
    [subscribers release];
    [requests release];
    [currentCookie release];
    
	[super dealloc];
}


@end
