Class {
	#name : #ExtendedService,
	#superclass : #Object,
	#instVars : [
		'registry',
		'id',
		'configuration',
		'logger'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #initialization }
ExtendedService class >> deploy [ 
	"For now just initialize"
	^ self new
]

{ #category : #acccessing }
ExtendedService >> clearLogger [
	logger := nil
]

{ #category : #initialization }
ExtendedService >> deploy [
	self loadConfiguration.
	self register.
]

{ #category : #acccessing }
ExtendedService >> id [
	^ id ifNil: [ id := self class name ].
]

{ #category : #initialization }
ExtendedService >> initialize [
	self loadConfiguration .
	self initializeLogger.
	registry := ServiceRegistry new.
	self register.
	
	
]

{ #category : #initialization }
ExtendedService >> initializeLogger [
	
	logger := Logger new.
	
	logger 
		homeDir: self logFolder;
		filename: self class name
]

{ #category : #running }
ExtendedService >> loadConfiguration [
	""

	| fn |
	fn := self defaultConfigurationPath asFileReference.

	configuration := fn exists
		ifTrue: [ fn readStream upToEnd asJson ]
		ifFalse: [ Dictionary new ].
	self postLoadConfiguration.
]

{ #category : #initialization }
ExtendedService >> logFolder [
	
	^ './logs/'
]

{ #category : #logging }
ExtendedService >> logInfo: anObject [
	logger ifNotNil: [ :l | l info: anObject  ].
]

{ #category : #running }
ExtendedService >> postLoadConfiguration [
	"do nothing by default"

	
]

{ #category : #'message interception' }
ExtendedService >> receiveMessage: aMessageStructure [
	"aMessage for now a Dictionary"

	| selector aMessage |
	
	selector := aMessageStructure  at: #selector.
	^ self perform: selector with: aMessageStructure .
]

{ #category : #initialization }
ExtendedService >> register [
	self logInfo: 'Registering service: ' , self class name.
	registry register: self by: self id.
]

{ #category : #'message interception' }
ExtendedService >> send: aMessage to: actor from: sender [
	""

	^ registry send: aMessage to: actor from: sender.
]

{ #category : #running }
ExtendedService >> stop [ 
	"clean up and unschedule if appropriate"
	self subclassResponsibility 
]
