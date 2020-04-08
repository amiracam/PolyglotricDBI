Class {
	#name : #RdmsService,
	#superclass : #ExtendedService,
	#instVars : [
		'client'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #utilities }
RdmsService class >> writeConfiguration [
	"self writeConfiguration "

	| json dict |
	
	dict := Dictionary new.
	
	dict 
		at: #driver 	put: 'postgres';
		at: #url 		put: 'psql://TEST_TBOSSS_ADMIN1:ADMIN1@192.168.40.107:5432/TEST_TBOSSS'.
	
	json := NeoJSONWriter toStringPretty: dict.
	
	'config.json' asFileReference writeStreamDo: [ :stream |
		stream nextPutAll: json
	 ]
]

{ #category : #initialization }
RdmsService >> checkConnectionStatus [

	[ client withConnection: [ :conn | [ conn isWorking ] ] ]
		on: ConnectionTimedOut
		do: [ :ex | ^ self logInfo: ex messageText ].

	self logInfo: 'Succesfully connected to database'.
]

{ #category : #services }
RdmsService >> connect: aMessage [

	self halt.
]

{ #category : #acccessing }
RdmsService >> connectionPoolFactory [
	^ P3ConnectionPool
]

{ #category : #initialization }
RdmsService >> connectionPoolSize [
	^ configuration at: 'size'.
]

{ #category : #initialization }
RdmsService >> initialize [
	"grab url from config file later"
	super initialize.
	self initializeDatabaseConnection.
]

{ #category : #initialization }
RdmsService >> initializeDatabaseConnection [
	" pull url into config"

	self logInfo: 'Connecting to database @', self serverUrl , ' pool size: ' , self connectionPoolSize asString.

	client := 
		self connectionPoolFactory new
			url: self serverUrl;
			size: self connectionPoolSize.
			
	self checkConnectionStatus
	
]

{ #category : #acccessing }
RdmsService >> serverUrl [
	^ configuration at: 'url'.
]
