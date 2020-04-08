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
	| logPath |
	
	logger := TinyLogger default.

	logger
		removeAllLoggers;
		timestampFormatBlock: [ :aStream :timestamp | 
			timestamp asDate printOn: aStream.
			aStream << ' '.	"Cannot use #space because of Stdio streams"
			timestamp asTime print24: true on: aStream
			].

	logPath := self logPath.
	logPath asFileReference ensureCreateFile.

	logger addFileLoggerNamed: logPath.
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
	| todaysFolder |
	
	todaysFolder := Date today printFormat: #(3 2 1 $- 1 1 2).

	^ './logs/' , todaysFolder , '/'.
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
