Class {
	#name : #RdmsService,
	#superclass : #ExtendedService,
	#instVars : [
		'client'
	],
	#classInstVars : [
		'ExceptionAnnouncer'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #announcements }
RdmsService class >> exceptionAnnouncer [
	"comment stating purpose of class-side message"

	^ ExceptionAnnouncer ifNil: [ ExceptionAnnouncer := Announcer new ].
]

{ #category : #initialization }
RdmsService >> checkConnectionStatus [
	[ 
	| result |
	
	result := 
	[ client withConnection: [ :conn | conn isWorking ] ]
		on: ConnectionTimedOut
		do: [ :ex | 
			self logInfo: ex messageText.
			ex return: false
			].
	result
		ifTrue:
			[ self logInfo: 'Succesfully connected to database @' , self serverUrl ]
	] fork.
]

{ #category : #services }
RdmsService >> connect: aMessage [
	self subclassResponsibility 
]

{ #category : #acccessing }
RdmsService >> connectionPoolFactory [
	^ P3ConnectionPool
]

{ #category : #initialization }
RdmsService >> connectionPoolSize [
	^ (configuration at: 'size').
]

{ #category : #initialization }
RdmsService >> initialize [
	"grab url from config file later"
	super initialize.
	self initializeDatabaseConnection.
]

{ #category : #initialization }
RdmsService >> initializeDatabaseConnection [

	client := self connectionPoolFactory new
		url: self serverUrl;
		size: self connectionPoolSize.

	self checkConnectionStatus.
]

{ #category : #initialization }
RdmsService >> initializeLogger [
	"grab url from config file later"

	super initializeLogger.
	self class exceptionAnnouncer
		when: RdmsAnnouncement
		do: [ :event | 
			Transcript show: 'Received RDMS announcement from P3 subscription.';cr.
			self logInfo: event error description
			].
]

{ #category : #acccessing }
RdmsService >> serverUrl [
	^ (configuration at: 'url') trim.
]

{ #category : #running }
RdmsService >> stop [
	
	self logInfo: 'Shuttindg down rdms client'.
	
	client ifNotNil: [ :c | c close ].
	client := nil.
	logger := nil.
	
]
