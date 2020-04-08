Class {
	#name : #SystemLauncher,
	#superclass : #ExtendedService,
	#instVars : [
		'services',
		'isDevelopment'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #writing }
SystemLauncher class >> writeDefaultConfiguration [
	"self writeDefaultConfiguration"

	| dict fn working stream |
	
	dict := Dictionary new.

	dict at: #services put: #().

	fn := self new defaultConfigurationPath.

	working := FileSystem disk workingDirectory.
	stream := (working / fn) writeStream.
	stream nextPutAll: (NeoJSONWriter toStringPretty: dict).
	stream close.
	
]

{ #category : #adding }
SystemLauncher >> addService: service [

	services add: service
	
]

{ #category : #initialization }
SystemLauncher >> initialize [
	ServiceRegistry new.
	super initialize.
	self launch.
]

{ #category : #initialization }
SystemLauncher >> initializeLogger [

	super initializeLogger  .
	self isDevelopment
		ifTrue: [ TinyLogger default addTranscriptLogger ].
]

{ #category : #'accessing-testing' }
SystemLauncher >> isDevelopment [
	^isDevelopment 
		ifNil: [ isDevelopment := (configuration at: 'isDevelopment') = 'true'. ]
	
]

{ #category : #adding }
SystemLauncher >> launch [

	self logInfo: 'Launching services: ' , services asString.
	services do: [ :service | service deploy ].
	self postLaunch.
]

{ #category : #initialization }
SystemLauncher >> postLoadConfiguration [

	services := 
		(configuration at: 'services')
			collect: [ :ea | Smalltalk at: ea asSymbol ].
]
