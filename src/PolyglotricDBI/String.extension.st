Extension { #name : #String }

{ #category : #'*PolyglotricDBI' }
String >> asJson [

	^ NeoJSONReader fromString:  self
]
