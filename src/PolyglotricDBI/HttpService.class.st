"
I handle route requests from clients
"
Class {
	#name : #HttpService,
	#superclass : #ExtendedService,
	#instVars : [
		'server'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #routes }
HttpService >> connect: httpRequest [
	| msgPackage sessionId dict |
	
	self logInfo: 'I HttpService received connect request'.
	msgPackage := httpRequest contents asJson.
	msgPackage at: #selector put: #connect:.
	"for now until I figure out the async way with Pharo"
	"expecting a session id if good"
	sessionId := self send: msgPackage to: #RdmsService from: self.
	dict := Dictionary new.
	dict at: #sessionId put: sessionId.
	
	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity json: (NeoJSONWriter toString: dict));
		yourself.
]

{ #category : #'initailize-release' }
HttpService >> initialize [
	"setup http server and routes"

	super initialize.
	server := Teapot configure: self teapotConfiguration.
	self initializeRoutes.
	self startServer.
]

{ #category : #'initailize-release' }
HttpService >> initializeRoutes [
	"setup http server and routes"

	self logInfo: 'Registering routes.'.
	server
		GET: '/heart_beat' -> [ :request | self testHeartBeat: request ];
		POST: '/testJsonPayload' -> [ :request | self testJsonPayload: request ];
		POST: '/connect' -> [ :request | self connect: request ].
]

{ #category : #'initailize-release' }
HttpService >> port [
	^ configuration at: 'port'.
]

{ #category : #'initailize-release' }
HttpService >> startServer [
	self logInfo: 'Starting server on port: ' , self port asString.
	server start.
]

{ #category : #'initailize-release' }
HttpService >> stop [ 
	^ server stop 
]

{ #category : #'initailize-release' }
HttpService >> teapotConfiguration [
	| coll |
	coll := OrderedCollection new.
	configuration keysAndValuesDo: [ :k :v | coll add: (Association key: k asSymbol  value: v )].
	^coll 
]

{ #category : #'private - testing' }
HttpService >> testHeartBeat: httpRequest [
	""

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity text: 'OK ');
		yourself.
]

{ #category : #'private - testing' }
HttpService >> testJsonPayload: httpRequest [
	""

	| dict |
	
	dict := httpRequest contents asJson.

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity text: 'Hello ' , (dict at: 'name'));
		yourself.
]
