Class {
	#name : #TBClientEvent,
	#superclass : #Object,
	#category : #'PolyglotricDBI-Events'
}

{ #category : #'instance-creation' }
TBClientEvent class >> newFrom: eventData [

	| header values |
	
	header := eventData copyFrom: 1 to: 3.
	values := (eventData copyFrom: 4 to: eventData size) splitOn: $|.
	
	self allSubclassesDo: [ :eaCls | 
		(eaCls name = header) 
			ifTrue:[^ (Smalltalk at: header asSymbol) onInstVarValues: values ]
		 ]
	
]

{ #category : #'as yet unclassified' }
TBClientEvent class >> onInstVarValues: aCollection [ 
	
	| inst |
	
	inst := self new.
	
	aCollection doWithIndex: [ :ea :i |inst instVarAt: i put: ea	].
		
	^ inst
]
