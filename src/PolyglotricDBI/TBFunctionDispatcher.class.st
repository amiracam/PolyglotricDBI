Class {
	#name : #TBFunctionDispatcher,
	#superclass : #RdmsFunctionDispatcher,
	#category : #'PolyglotricDBI-Services'
}

{ #category : #messages }
TBFunctionDispatcher >> announceException: ex [
	RdmsService exceptionAnnouncer
		announce: (RdmsAnnouncement new message: ex description).
]

{ #category : #messages }
TBFunctionDispatcher >> announceProcessedEvent: anEvent [
	^ RdmsService exceptionAnnouncer
		announce:
			(RdmsAnnouncement new
				message: ('Processed event: {1}' format: {anEvent.})).
]

{ #category : #'instance creation' }
TBFunctionDispatcher >> newEventFrom: evData [
	^ self rdmsEventFactory newFrom: evData.
]

{ #category : #'as yet unclassified' }
TBFunctionDispatcher >> rdmsEventFactory [
	^ TBClientEvent 
]

{ #category : #services }
TBFunctionDispatcher >> rdmsFunctionFactory [
	^ TBStoredProcedure.
]

{ #category : #messages }
TBFunctionDispatcher >> runProcedure: anEvent [
| events |
self halt. 
	events := (anEvent at: 'eventList') collect: [ :ea | self newEventFrom: ea ].
	anEvent at: 'eventList' put: events.
	client
		withConnection: [ :conn | 
			[ self serverTransactionFactory forEvent: anEvent on: conn.
			  self announceProcessedEvent: anEvent
			]
				on: TransactionAborted
				do: [ :ex | 
					self announceException: ex.
					^ ex return
					]
			].
]

{ #category : #services }
TBFunctionDispatcher >> serverTransactionFactory [
	^ TBServerTransaction 
]
