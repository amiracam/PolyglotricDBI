Class {
	#name : #UPW,
	#superclass : #TBClientEvent,
	#instVars : [
		'user'
	],
	#category : #'PolyglotricDBI-Events'
}

{ #category : #accessing }
UPW >> user [
	^ user
]

{ #category : #accessing }
UPW >> user: anObject [
	user := anObject
]
