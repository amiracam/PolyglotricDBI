Class {
	#name : #RdmsServerTransaction,
	#superclass : #Object,
	#instVars : [
		'connection',
		'eventList'
	],
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #construction }
RdmsServerTransaction class >> forEvent: eventList on: client [

	| inst |
	
	inst := self new.
	
	inst eventList: eventList.
	inst connection: client.
	
	^ inst process.
	
	
]

{ #category : #accessing }
RdmsServerTransaction >> connection [
	^ connection
]

{ #category : #accessing }
RdmsServerTransaction >> connection: anObject [
	connection := anObject
]

{ #category : #accessing }
RdmsServerTransaction >> eventList [
	^ eventList
]

{ #category : #accessing }
RdmsServerTransaction >> eventList: anObject [
	eventList := anObject
]

{ #category : #accessing }
RdmsServerTransaction >> functionFactory [
	^ TBStoredProcedure.
]

{ #category : #events }
RdmsServerTransaction >> newEventFrom: evData [
	^ self rdmsEventFactory newFrom: evData.
]

{ #category : #processing }
RdmsServerTransaction >> process [
	
	
	| function |
	
	connection
		inTransaction: [ :ctx | 
			self flag: #todo.
			"We probably need a better object than a dictionary to house the incoming event requests"
			
			((eventList at: #eventList))
				do:
					[ :evData |
					function := self functionFactory process: evData on: ctx ]
		].
		
	^ function
]

{ #category : #events }
RdmsServerTransaction >> rdmsEventFactory [
	^ RdmsEvent
]
