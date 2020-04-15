Class {
	#name : #SystemLauncher,
	#superclass : #ExtendedService,
	#instVars : [
		'services',
		'isDevelopment'
	],
	#category : #'PolyglotricDBI-Services'
}

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

{ #category : #running }
SystemLauncher >> stop [
	"no op"
	
]

{ #category : #'as yet unclassified' }
SystemLauncher >> undeploy [
	
	self logInfo: 'Undeploying services: ', services asString.
	registry ifNotNil: [ registry stop ] .
	
	registry := nil.
	services := nil.
]
