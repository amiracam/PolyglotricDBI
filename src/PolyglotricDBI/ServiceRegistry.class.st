Class {
	#name : #ServiceRegistry,
	#superclass : #Object,
	#instVars : [
		'registry',
		'configuration'
	],
	#classVars : [
		'singleton'
	],
	#category : #'PolyglotricDBI-Services'
}

{ #category : #'instance creation' }
ServiceRegistry class >> new [ 
	singleton ifNil: [ singleton := self basicNew initialize ]
]

{ #category : #initialization }
ServiceRegistry >> initialize [ 

	registry  := IdentityDictionary new.
]

{ #category : #initialization }
ServiceRegistry >> register: actor by: id [
""
	registry at: id put: actor.
]
