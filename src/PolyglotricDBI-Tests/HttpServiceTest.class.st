"
A HttpServiceTest is a test class for testing the behavior of HttpService
"
Class {
	#name : #HttpServiceTest,
	#superclass : #TestCase,
	#category : #'PolyglotricDBI-Tests-Services'
}

{ #category : #test }
HttpServiceTest >> testHearBeat [
	| response |
	""
	response := ZnClient new
		timeout: 2;
		logToTranscript;
		enforceHttpSuccess: true;
		ifFail:
				[ :ex | self inform: 'Fail to process heart_beat request: ' , ex printString ];
		http;
		enforceAcceptContentType: true;
		accept: ZnMimeType textPlain;
		host: 'localhost';
		port: 1701;
		addPath: 'heart_beat';
		get;
		response.

	self assert: response contents equals: 'OK'.
]

{ #category : #test }
HttpServiceTest >> testTestJsonPayload [
	| dict response |
	""
	
	dict := Dictionary new.
	dict at: 'name' put: 'charles'.

	response := 
	ZnClient new
		timeout: 200;
		logToTranscript;
		enforceHttpSuccess: true;
		ifFail:
				[ :ex | self inform: 'Fail to process JSON payload test: ' , ex printString ];
		http;
		enforceAcceptContentType: true;
		accept: ZnMimeType textPlain;
		host: 'localhost';
		port: 1701;
		addPath: 'testJsonPayload';
		entity:
			(ZnEntity
				with: (NeoJSONWriter toString: dict)
				type: ZnMimeType applicationJson);
		post;
		response.

	response writeOn: Transcript.
	Transcript flush.
]
