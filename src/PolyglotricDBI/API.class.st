Class {
	#name : #API,
	#superclass : #Object,
	#instVars : [
		'response',
		'format',
		'zipped',
		'sessionId',
		'databaseBroker'
	],
	#category : #'PolyglotricDBI-Commands'
}

{ #category : #processing }
API >> formatRecords [

	self perform format,'Format' with: self response
]

{ #category : #initialization }
API >> initialize [ 

	format := 'json'.
	zipped := false.
]

{ #category : #formatting }
API >> jsonFormat: data [ 

	^ NeoJSONWriter toString: data 
]

{ #category : #private }
API >> logInfo: aString [
	"Using TinyLogger"
	
	aString record
]

{ #category : #processing }
API >> performer [

	^ self class name lowercase 
]

{ #category : #playing }
API >> play [ 
	self shouldBeImplemented 
]

{ #category : #processing }
API >> playOn: application [ 
	
	self play 
]

{ #category : #processing }
API >> processOn: application [ 

	application perform: self performer with: self.
	self logInfo: 'API is: ' , self class name asString.
	
	^ self formatRecords
]
