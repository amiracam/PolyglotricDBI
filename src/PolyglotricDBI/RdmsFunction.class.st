Class {
	#name : #RdmsFunction,
	#superclass : #Object,
	#instVars : [
		'rdmsClient'
	],
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #'as yet unclassified' }
RdmsFunction >> process: aTST [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
RdmsFunction >> rdmsClient [
	^ rdmsClient
]

{ #category : #accessing }
RdmsFunction >> rdmsClient: anObject [
	rdmsClient := anObject
]
