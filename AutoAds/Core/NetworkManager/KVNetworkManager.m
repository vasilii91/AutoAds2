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

- (KVUrlRequest *)createMultipartFormRequest:(NSOutputStream*)outputStream url:(NSString*)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier jsonString:(NSString *)jsonString;
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

- (KVUrlRequest *)createMultipartFormRequest:(NSOutputStream*)outputStream url:(NSString*)urlStr requestType:(RequestType)requestType requestIdentifier:(NSString *)identifier jsonString:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    static NSString* const BOUNDRY = @"6490653261771490969735433975";
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    NSMutableData *body = [[NSMutableData alloc] init];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", currentDevice.name] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n\r\n%@", currentDevice.name] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",@"request.json"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    
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

- (NSString *)urlGetWithActionName:(NSString *)actionName parameters:(NSString *)parameters
{
    NSString *url = [NSString stringWithFormat:SERVER_URL_GET_FORMAT, [[[AdvDictionaries HostLinks] allKeys] objectAtIndex:1], actionName, parameters];
    
    return url;
}


#pragma mark -
#pragma mark Public methods

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

- (void)search
{
    NSString *jsonString = @"rubric=motors&subrubric=rus&MileageMax=100000&Drive=FWD&Gearbox=MT&Fuel=GAS";
    NSString *url = [self urlGetWithActionName:@"Search" parameters:jsonString];
    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:url requestType:RequestTypeSearch requestIdentifier:@"" jsonString:nil httpMethod:@"GET"];
    
    [self addRequest:urlRequest];
}

- (void)getModelsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    NSString *jsonString = [NSString stringWithFormat:@"rubric=%@&subrubric=%@", rubric, subrubric];
    NSString *url = [self urlGetWithActionName:@"Brands" parameters:jsonString];
    KVUrlRequest *urlRequest = [self requestToServer:[NSOutputStream outputStreamToMemory] url:url requestType:RequestTypeBrands requestIdentifier:@"" jsonString:nil httpMethod:@"GET"];
    
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
