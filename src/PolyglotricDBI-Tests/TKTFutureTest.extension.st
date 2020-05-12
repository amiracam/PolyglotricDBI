Extension { #name : #TKTFutureTest }

{ #category : #'*PolyglotricDBI-Tests' }
TKTFutureTest >> testAllFuturesFailure [
	| allFuture |
	allFuture := TKTFuture
		all:
			{[ (Time now asString , ': 1') traceCr.
			10 seconds wait.
			3
			] future.
			[ (Time now asString , ': 2') traceCr.
			1 seconds wait.
			1
			] future.}.

	allFuture
		onSuccessDo: [ :val | (Time now asString , ': completed all futures') traceCr ].
	allFuture future.
	self assert: true.

	12 seconds wait.
]

{ #category : #'*PolyglotricDBI-Tests' }
TKTFutureTest >> testAllFuturesFailure2 [
	| allFuture result semaphore successCalled |
	allFuture := TKTFuture
		all:
			{[ 100 atRandom milliSeconds wait.
			3
			] future.
			[ 100 atRandom milliSeconds wait.
			1
			] future.
			[ Error signal: 'Did not go too well' ] future.
			[ 100 atRandom milliSeconds wait.
			2
			] future.}.

	"semaphore := Semaphore new."

	successCalled := false.

	allFuture onSuccessDo: [ :value | successCalled := true ].


	allFuture
		onFailureDo: [ :error | 
			result := error

			"semaphore signal"
			].

	"semaphore wait."



	self assert: successCalled not.
	self assert: result messageText equals: 'Did not go too well'.
]

{ #category : #'*PolyglotricDBI-Tests' }
TKTFutureTest >> testAllFuturesFailurexxxx [
	| allFuture |
	allFuture := TKTFuture
		all:
			{[ (Time now asString , ': 1') traceCr.
			10 seconds wait.
			3
			] future.
			[ (Time now asString , ': 2') traceCr.
			1 seconds wait.
			1
			] future.}.

	allFuture
		onSuccessDo: [ :val | (Time now asString , ': completed all futures') traceCr ].
	self assert: true.

	12 seconds wait.
]
