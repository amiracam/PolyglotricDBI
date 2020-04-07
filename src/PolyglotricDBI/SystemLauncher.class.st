Class {
	#name : #SystemLauncher,
	#superclass : #ExtendedService,
	#instVars : [
		'services'
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
SystemLauncher >> addService: serviceName [

	services add: serviceName
	
]

{ #category : #initialization }
SystemLauncher >> initialize [
	services := OrderedCollection new.
	"Setup registry singleton"
	ServiceRegistry new.
	TinyLogger default
		addTranscriptLogger;
		addFileLoggerNamed: self logPath.
]

{ #category : #adding }
SystemLauncher >> launch [ 

	 services do:[:service | service deploy]
]
