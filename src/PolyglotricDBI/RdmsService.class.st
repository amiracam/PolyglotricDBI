Class {
	#name : #RdmsService,
	#superclass : #ExtendedService,
	#instVars : [
		'connection'
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
	| healthy  |
	
	healthy := connection
		in: [ :client | 
			[ client isWorking ]
				ensure: [ client close ] ].
			
	self assert: healthy.
	'Succesfully connected to database' record.
]

{ #category : #services }
RdmsService >> connect: aMessage [

	self halt.
]

{ #category : #initialization }
RdmsService >> initialize [
	"grab url from config file later"
	super initialize.
	self initializeLogger.
	self initializeDatabaseConnection.
]

{ #category : #initialization }
RdmsService >> initializeDatabaseConnection [
	" pull url into config"
	connection := P3Client new
		url: 'psql://TEST_TBOSSS_ADMIN1:ADMIN1@192.168.40.107:5432/TEST_TBOSSS'.

	self checkConnectionStatus.
]

{ #category : #initialization }
RdmsService >> initializeLogger [

	TinyLogger default
		timestampFormatBlock: [ :aStream :timestamp | 
			timestamp asDate printOn: aStream.
			aStream << ' '.	"Cannot use #space because of Stdio streams"
			timestamp asTime print24: true on: aStream ].
		
	TinyLogger default addFileLoggerNamed: 'polyglotric.log'
]
