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
	| msgPackage |
	
	msgPackage := httpRequest contents.
	msgPackage at: #selector put: #connect:.
	self send: msgPackage to: #RdmsService.
]

{ #category : #'initailize-release' }
HttpService >> defaultConfiguration [
	^  configuration
]

{ #category : #'initailize-release' }
HttpService >> initialize [
	"setup http server and routes"

	super initialize.
	server := Teapot configure: self defaultConfiguration.
	self initializeRoutes.
	server start.
]

{ #category : #'initailize-release' }
HttpService >> initializeRoutes [
	"setup http server and routes"


	server
		GET: '/heart_beat' -> [ :request | self testHeartBeat: request ];
		POST: '/testJsonPayload' -> [ :request | self testJsonPayload: request ];
		POST: '/connect' -> [ :request | self connect: request ].
]

{ #category : #'initailize-release' }
HttpService >> stop [ 
	^ server stop 
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
