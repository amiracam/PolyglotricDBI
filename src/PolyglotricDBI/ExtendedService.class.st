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

	logger := TinyLogger default.

	TinyLogger default
		removeAllLoggers;
		timestampFormatBlock: [ :aStream :timestamp | 
			timestamp asDate printOn: aStream.
			aStream << ' '.	"Cannot use #space because of Stdio streams"
			timestamp asTime print24: true on: aStream
			].

	TinyLogger default addFileLoggerNamed: self logPath.
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
	^ './logs/'.
]

{ #category : #logging }
ExtendedService >> logInfo: aString [ 

	"assumes TinyLogger protocol"
	
	aString record.
]

{ #category : #initialization }
ExtendedService >> logPath [
	^ self logFolder , self class name , '.log'.
]

{ #category : #running }
ExtendedService >> postLoadConfiguration [
	"do nothing by default"

	
]

{ #category : #'message interception' }
ExtendedService >> receiveMessage: aMessage [
	"aMessage for now a Dictionary"

	| selector |
	
	selector := aMessage selector.
	self perform: selector with: aMessage.
]

{ #category : #initialization }
ExtendedService >> register [
	self logInfo: 'Registering service: ' , self class name.
	registry register: self by: self id.
]

{ #category : #'message interception' }
ExtendedService >> send: aMessage to: actor [
""
	^ [ registry at: actor ] receiveMessage: aMessage.
]
