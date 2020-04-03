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
	
	^ singleton ifNil: [ singleton := self new ]
]

{ #category : #deployment }
HttpService class >> undeploy [
	"self undeploy"

	^ singleton stop
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
		GET: '/heart_beat' -> 'OK'
]

{ #category : #'initailize-release' }
HttpService >> stop [ 
	^ server stop 
]
