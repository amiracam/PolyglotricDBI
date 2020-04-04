Class {
	#name : #NeoJsonLearning,
	#superclass : #TestCase,
	#category : #'PolyglotricDBI-Tests-Utilities'
}

{ #category : #tests }
NeoJsonLearning >> testNeoJsonStringExtension [
	| dict string |
	
	dict := Dictionary new.
	dict at: 'name' put: 'charles'.
	string := NeoJSONWriter toString: dict.
	self assert: string asJson equals: dict
]
