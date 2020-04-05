Class {
	#name : #BaselineOfPolyglotricDBI,
	#superclass : #BaselineOf,
	#category : #BaselineOfPolyglotricDBI
}

{ #category : #adding }
BaselineOfPolyglotricDBI >> addP3: spec [ 

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
		do: [ "Dependencies"
			self addP3: spec.

			"Packages"

			spec
				package: 'PolyglotricDBI';
				package: 'PolyglotricDBI-Tests'
					with: [ spec requires: #('PolyglotricDBI') ];
				baseline: 'NeoJSON'
					with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
				baseline: 'ZTimestamp'
					with: [ spec repository: 'github://svenvc/ztimestamp:master/repository' ]
			].
]
