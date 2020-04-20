Extension { #name : #P3Client }

{ #category : #'*PolyglotricDBI' }
P3Client >> beginTransaction [ 

	self execute: 'BEGIN'
]

{ #category : #'*PolyglotricDBI' }
P3Client >> commitTransaction [ 

	self execute: 'COMMIT'
]

{ #category : #'*PolyglotricDBI' }
P3Client >> inTransaction: closure [
	""

	self beginTransaction.

	[ closure value: self.
	self commitTransaction
	]
		on: P3Error
		do: [ :ex | 
			self rollbackTransaction.
			TransactionAborted new signal: ex description
			].
]

{ #category : #'*PolyglotricDBI' }
P3Client >> rollbackTransaction [ 

	self execute: 'ROLLBACK'
]
