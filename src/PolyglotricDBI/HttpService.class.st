Class {
	#name : #HttpService,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #deployment }
HttpService class >> deploy [
	"self deploy"
	self undeploy.
	singleton := self new 
]

{ #category : #deployment }
HttpService class >> undeploy [
	"self undeploy"

	singleton
		ifNotNil: [ 
			singleton stop.
			singleton := nil
			].
]

{ #category : #'initailize-release' }
HttpService >> defaultConfiguration [ 		
	
	^ {  }
]

{ #category : #'initailize-release' }
HttpService >> initialize [ 
	"setup http server and routes"
	"scope: class-variables  &  instance-variables"	
			
	
	server := Teapot configure: self defaultConfiguration.
	self initializeRoutes.
	server start. 
]

{ #category : #'initailize-release' }
HttpService >> initializeRoutes [
	"setup http server and routes"

	"scope: class-variables  &  instance-variables"

	server 
		GET: '/heart_beat' -> 'OK';
		POST: '/testJsonPayload' -> [ :request | self testJsonPayload: request ]
]

{ #category : #'initailize-release' }
HttpService >> stop [ 
	^ server stop 
]

{ #category : #'private - testing' }
HttpService >> testJsonPayload: httpRequest [
	""

	| dict |
	dict := NeoJSONReader fromString: httpRequest contents.

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity text: 'Hello ' , (dict at: 'name'));
		yourself.
]
