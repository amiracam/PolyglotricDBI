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

	registry := ServiceRegistry new.
	logger := TinyLogger default.
	
]

{ #category : #running }
ExtendedService >> loadConfiguration [
	""

	| fn |
	
	fn := self defaultConfigurationPath .

	configuration := 
		fn exists
			ifTrue: [ fn readStream upToEnd asJson ]
			ifFalse: [ Dictionary new ].
]

{ #category : #initialization }
ExtendedService >> logPath [
	^ './' , self class name , '.log'.
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
	self registry register: self by: self id.
]

{ #category : #'message interception' }
ExtendedService >> send: aMessage to: actor [
""
	^ [ registry at: actor ] receiveMessage: aMessage.
]
