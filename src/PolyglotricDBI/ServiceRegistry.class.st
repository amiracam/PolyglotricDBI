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
	^ singleton ifNil: [ singleton := self basicNew initialize ]
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

{ #category : #initialization }
ServiceRegistry >> send: aMessage to: actor from: sender [
	"handle async , use send response to sender ? use TKActors ?"

	^ (registry at: actor) receiveMessage: aMessage.
]
