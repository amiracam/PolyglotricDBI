Class {
	#name : #TBServerTransaction,
	#superclass : #RdmsServerTransaction,
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #accessing }
TBServerTransaction >> rdmsEventFactory [
	"Move over to TB specific package"
	^ TBClientEvent 
]
