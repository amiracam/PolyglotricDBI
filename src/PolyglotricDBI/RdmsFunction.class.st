Class {
	#name : #RdmsFunction,
	#superclass : #Object,
	#instVars : [
		'rdmsClient'
	],
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #running }
RdmsFunction >> execute: sql [
	"convenience"
	
	self rdmsClient execute: sql
]

{ #category : #running }
RdmsFunction >> executeStatement: sql [
	"convenience, setup a server side prepared statement"

	^ self rdmsClient prepare: sql.
]

{ #category : #running }
RdmsFunction >> prepare: sql [
	"convenience, setup a server side prepared statement"

	^ self rdmsClient prepare: sql.
]

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
