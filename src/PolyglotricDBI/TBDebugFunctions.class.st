Class {
	#name : #TBDebugFunctions,
	#superclass : #TBStoredProcedure,
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #processing }
TBDebugFunctions >> processTST [
	| stmnt |
	""
	self
		execute: 'DROP TABLE IF EXISTS TstTable';
		execute:
			'CREATE TABLE TstTable (id INTEGER, name TEXT, active BOOLEAN, start DATE)'.

	stmnt := self
		prepare: 'INSERT INTO TstTable (id, name, active, start) VALUES ($1, $2, $3, $4)'.

	[ stmnt
		execute:
			{event id.
			event name.
			event active.
			event start.}
	]
		ensure: [ stmnt close ].
]
