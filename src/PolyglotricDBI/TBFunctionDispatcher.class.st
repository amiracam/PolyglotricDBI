Class {
	#name : #TBFunctionDispatcher,
	#superclass : #RdmsFunctionDispatcher,
	#category : #'PolyglotricDBI-Services'
}

{ #category : #services }
TBFunctionDispatcher >> rdmsFunctionFactory [
	^ TBStoredProcedure.
]

{ #category : #messages }
TBFunctionDispatcher >> runProcedure: anEvent [
	client
		withConnection: [ :conn | 
			[ self serverTransactionFactory forEvent: anEvent on: conn.
			  self logInfo: ('Processed event: {1}' format: {anEvent.})
			]
				on: TransactionAborted
				do: [ :ex | 
					self logInfo: ex description.
					^ ex return
					]
			].
]

{ #category : #services }
TBFunctionDispatcher >> serverTransactionFactory [
	^ TBServerTransaction 
]
