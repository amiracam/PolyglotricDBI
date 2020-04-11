Class {
	#name : #NoTBEventHandler,
	#superclass : #Exception,
	#category : #'PolyglotricDBI-Error handling'
}

{ #category : #accessing }
NoTBEventHandler >> defaultAction [
	"The default action taken if the exception is signaled."
	"no op"

]

{ #category : #signaling }
NoTBEventHandler >> signal: signalerText [

	^ super signal: 'No Event handler available for: ', signalerText
	
]
