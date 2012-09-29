//
//  KVUrlRequest.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KVUrlRequest.h"

#ifndef NAS_URL_REQUEST_TIMEOUT
    #define NAS_URL_REQUEST_TIMEOUT 15
#endif

static NSString *NAS_Error_Domain = @"NASAppErrorDomain";

@implementation KVUrlRequest

@synthesize outputStream = _outputStream;
@synthesize request = _request;
@synthesize httpResponse = _httpResponse;
@synthesize delegate = _delegate;
@synthesize didFail = _didFail;
@synthesize type = _tag;
@synthesize identifier = _identifier;


#pragma mark - Public methods

- (id)initWithStream:(NSOutputStream*)stream request:(NSURLRequest*)request 
{	
	self = [super init];
	
	if (self) {
		
		_outputStream = stream;
		[_outputStream retain];
		
		_request = request;
		[_request retain];
        
        dataManager = [KVDataManager sharedInstance];
        dataManager.delegate = self;
	}
	
	return self;
}

- (id)initWithStream:(NSOutputStream*)stream url:(NSString*)url 
{	
	return [self initWithStream:stream request:[NSMutableURLRequest 
		requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] 
		cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:NAS_URL_REQUEST_TIMEOUT]];
}

- (BOOL)start 
{	
	if (_outputStream && _request) {
		
		[_outputStream open];
		
		_connection = [NSURLConnection connectionWithRequest:_request delegate:self];
        
		[_connection retain];
		
		return YES;
	}
	
	return NO;
}

- (void)stop 
{	
	self.delegate = nil;
	
    if (_connection != nil) {
        [_connection cancel];
        [_connection release];
		_connection = nil;
    }
	
    if (_outputStream != nil) {
        [_outputStream close];
    }
}


- (NSString *)getUrl 
{	
	return [[_request URL] absoluteString];
}

- (NSData *)getContent 
{	
	return [_request HTTPBody];
}


#pragma mark - Private methods

- (NSError *)createErrorWithCode:(NSInteger)errorCode description:(NSString *)description reason:(NSString *)reason
{
    NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
    NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSLocalizedFailureReasonErrorKey, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
    NSError* error = [NSError errorWithDomain:NAS_Error_Domain code:errorCode userInfo:userInfo];
    
    return error;
}


#pragma mark - NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection*)theConnection didReceiveData:(NSData*)data 
{
	const uint8_t *dataBytes;
	
	int dataLength;
	int bytesWritten;
	int bytesWrittenSoFar;
	
	dataLength = [data length];
	dataBytes = [data bytes];
	
	bytesWrittenSoFar = 0;
	
	do {
		bytesWritten = [_outputStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
		
		if (bytesWritten == -1) {
			
			_didFail = YES;
			[_delegate requestFailed:self error:[_outputStream streamError]];
			[self stop];
			break;
		}
		else {
			bytesWrittenSoFar += bytesWritten;
		}
	}
	while (bytesWrittenSoFar != dataLength);
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse*)response 
{	
	_httpResponse = (NSHTTPURLResponse*)response;
	[_httpResponse retain];
}

- (void)connection:(NSURLConnection*)theConnection didFailWithError:(NSError*)error 
{	
	_didFail = YES;
	[_delegate requestFailed:self error:error];
	[self stop];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{	
    NSInteger statusCode = [_httpResponse statusCode];
    LOG(@"%d", statusCode);
    
    if (statusCode == 200) {
        [dataManager saveData:_outputStream withRequestType:_tag identifier:_identifier];
    }
    else {
        NSString *errorReason = [KVDataLogic descriptionByStatusCode:statusCode];
        NSError *error = [self createErrorWithCode:statusCode description:errorReason reason:errorReason];
        [_delegate requestFailed:self error:error];
    }
}


#pragma mark - @protocol KVDataManagerDelegate <NSObject>

- (void)dataWasSuccessfullyParsed
{
    [_delegate requestSuccess:self];
    [self stop];
}

- (void)errorWasOccuredWithError:(NSString *)textError
{
    NSError *error = [self createErrorWithCode:0 description:textError reason:textError];
    [_delegate requestFailed:self error:error];
}


#pragma mark - Memory management

- (void)dealloc 
{
	[_connection release];
	[_request release];
	[_outputStream release];
	[_httpResponse release];
	[_delegate release];
    [_identifier release];
	
	[super dealloc];
}
@end
