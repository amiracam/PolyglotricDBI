Class {
	#name : #TBStoredProcedure,
	#superclass : #RdmsFunction,
	#instVars : [
		'event',
		'rowCount',
		'errorCode',
		'returnMsg',
		'logAction',
		'logResult'
	],
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #'event handling - private' }
TBStoredProcedure class >> handlerFor: aTBClientEvent [

	| method |
	
	method := ('process', aTBClientEvent class name) asSymbol.
	
	self allSubclassesDo: [ :eaCls |
		(eaCls selectors includes: method)
			ifTrue: [ 
				 |function|
				
				 function := eaCls new.
				 function event: aTBClientEvent.
				 
				 ^ MessageSend receiver: function selector: method
			]
   ].

	NoTBEventHandler new signal: 'method: ', method

]

{ #category : #accessing }
TBStoredProcedure class >> process: aMessage on: connection [

	| handler |
	
	handler := self handlerFor: aMessage.
	handler receiver rdmsClient: connection.
   handler value.
]

{ #category : #'as yet unclassified' }
TBStoredProcedure >> announce: info [
	^ self serviceAnnouncer announce: (RdmsAnnouncement new message: info).
]

{ #category : #accessing }
TBStoredProcedure >> event: anObject [
	event := anObject
]

{ #category : #'as yet unclassified' }
TBStoredProcedure >> logInfo [
	
	
	{logAction.} do:[ :ea | self announce: ea ].
]

{ #category : #'as yet unclassified' }
TBStoredProcedure >> serviceAnnouncer [
	^ RdmsService exceptionAnnouncer.
]
