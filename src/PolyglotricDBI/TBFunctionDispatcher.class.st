Class {
	#name : #TBFunctionDispatcher,
	#superclass : #RdmsFunctionDispatcher,
	#category : #'PolyglotricDBI-Services'
}

{ #category : #services }
TBFunctionDispatcher >> rdmsFunctionFactory [
	^ TBStoredProcedure.
]

{ #category : #services }
TBFunctionDispatcher >> serverTransactionFactory [
	^ TBServerTransaction.
]
