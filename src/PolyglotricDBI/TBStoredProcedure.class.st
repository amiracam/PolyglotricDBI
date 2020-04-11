Class {
	#name : #TBStoredProcedure,
	#superclass : #RdmsFunction,
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #'event handling - private' }
TBStoredProcedure class >> handlerFor: aTBClientEvent [

	| method |
	
	method := aTBClientEvent method.
	
	self allSubclassesDo: [ :eaCls |
		(eaCls selectors includes: method)
			ifTrue: [^ eaCls new ]
   ].

	NoTBEventHandler new signal: 'method: ', method

]

{ #category : #accessing }
TBStoredProcedure class >> process: aMessage [
	
	self handlerFor: aMessage
]
