Class {
	#name : #StringExtensionsTests,
	#superclass : #TestCase,
	#category : #'PolyglotricDBI-Tests-Commands'
}

{ #category : #tests }
StringExtensionsTests >> testAsJson [
	
	| dict json string |
	
	dict := Dictionary new.
	dict at: 'name' put: 'charles'.
	
	json := NeoJSONWriter toStringPretty: dict.
	
	string := '{
	"name" : "charles"
}'.

	self assert: json equals: string.
]
