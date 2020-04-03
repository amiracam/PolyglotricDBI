Class {
	#name : #BaselineOfPolyglotricDBI,
	#superclass : #BaselineOf,
	#category : #BaselineOfPolyglotricDBI
}

{ #category : #baselines }
BaselineOfPolyglotricDBI >> addP3: spec [
	"Sven Postgres driver"
	
			
	spec 
		baseline: 'BaselineOfP3'
		with: [ 
					spec 
						with: [ spec repository: 'github://github.com/svenvc/P3' ]
	   ]
]

{ #category : #baselines }
BaselineOfPolyglotricDBI >> baseline: spec [ 
	<baseline>
	
	spec 
		for: #common
		do: [ 
			"Dependencies"
			
			self addP3: spec. 
			
			"Packages"
				spec 
					package: 'PolyglotricDBI';
					package: 'PolyglotricDBI-Tests' with: [ spec requires: #('PolyglotricDBI') ]
			 ]
]
