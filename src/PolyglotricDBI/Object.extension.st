Extension { #name : #Object }

{ #category : #'*PolyglotricDBI' }
Object >> defaultConfigurationPath [

	^ ('./config/' , self class name , '.json')

	
]

{ #category : #'*PolyglotricDBI' }
Object >> toJson [

	^ NeoJSONWriter toString: self.
]
