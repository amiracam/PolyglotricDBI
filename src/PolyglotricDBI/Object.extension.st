Extension { #name : #Object }

{ #category : #'*PolyglotricDBI' }
Object >> defaultConfigurationPath [

	^ ('./config/' , self class name , '.json')

	
]
