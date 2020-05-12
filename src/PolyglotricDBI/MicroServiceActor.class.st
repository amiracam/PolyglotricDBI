Class {
	#name : #MicroServiceActor,
	#superclass : #ExtendedServiceActor,
	#instVars : [
		'server'
	],
	#category : #'PolyglotricDBI-Actors'
}

{ #category : #initialization }
MicroServiceActor >> connect: httpRequest [
	<todo>
	| msgPackage sessionId dict |
	self logInfo: 'I HttpService received connect request'.
	msgPackage := httpRequest contents asJson.
	msgPackage at: #selector put: #connect:.
	
	"for now until I figure out the async way with Pharo"
	"expecting a session id if good"
	
	sessionId := 
		self
			send: msgPackage
			to: #TBFunctionDispatcher
			from: self.
			
	dict := Dictionary new.
	dict at: #sessionId put: sessionId.

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity json: (NeoJSONWriter toString: dict));
		yourself.
]

{ #category : #initialization }
MicroServiceActor >> initialize [
	"setup http server and routes"
	
	super initialize.
	server := Teapot configure: self teapotConfiguration.
	self initializeRoutes.
	self startServer.
]

{ #category : #initialization }
MicroServiceActor >> initializeRoutes [
	"setup http server and routes"

	self logInfo: 'Registering routes.'.
	server
		GET: '/heart_beat' -> [ :request | self testHeartBeat: request ];
		POST: '/testJsonPayload' -> [ :request | self testJsonPayload: request ];
		POST: '/connect' -> [ :request | self connect: request ].
]

{ #category : #initialization }
MicroServiceActor >> port [
	^ configuration at: 'port'.
]

{ #category : #initialization }
MicroServiceActor >> startServer [

	self logInfo: 'Starting server on port: ' , self port asString.
		
	server start.

]

{ #category : #running }
MicroServiceActor >> stop [ 

	self logInfo: 'Stopping Server'.
	server ifNotNil: [:s | s stop ].
	ZnLogEvent announcer unsubscribe: self.
	logger := nil.
	server := nil.
	registry := nil.
	

]

{ #category : #initialization }
MicroServiceActor >> teapotConfiguration [
	| coll |
	coll := OrderedCollection new.
	configuration keysAndValuesDo: [ :k :v | coll add: (Association key: k asSymbol  value: v )].
	^coll 
]

{ #category : #initialization }
MicroServiceActor >> testHeartBeat: httpRequest [
	""

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity text: 'OK ');
		yourself.
]

{ #category : #initialization }
MicroServiceActor >> testJsonPayload: httpRequest [
	""

	| dict |
	
	dict := httpRequest contents asJson.

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity text: 'Hello ' , (dict at: 'name'));
		yourself.
]
