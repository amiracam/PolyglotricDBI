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
	
	^ inst process 
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
	""
	connection
		inTransaction: [ :ctx | 
			((eventList at: #eventList) splitOn: Character cr)
				do:
					[ :evData |
						 self 
							functionFactory 
							process: (self newEventFrom: evData) on: ctx ]
			].
]

{ #category : #events }
RdmsServerTransaction >> rdmsEventFactory [
	^ RdmsEvent
]
