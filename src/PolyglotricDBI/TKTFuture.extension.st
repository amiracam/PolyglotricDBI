Extension { #name : #TKTFuture }

{ #category : #'*PolyglotricDBI' }
TKTFuture class >> all: aCollection [
	"Create a all future from aCollection of futures. The all future resolves if all of

	the futures in aCollection resolve. The values given to the success handler are the

	values of the futures in aCollection in the same order they appear in aCollection. The

	first future in aCollection that fails marks this future as failed"

	| results future |
	results := OrderedCollection new: aCollection size.



	future := self new.


	aCollection
		withIndexDo: [ :each :index | 
			each
				onSuccessDo: [ :value | 
					results add: index -> value.


					results size = aCollection size
						ifTrue:
							[ future deploySuccess: (results sorted collect: #value) asArray ]
					].


			each onFailureDo: [ :fail | future deployFailure: fail ]
			].


	^ future.
]

{ #category : #'*PolyglotricDBI' }
TKTFuture class >> any: aCollection [ 

	"Create any future from aCollection of futures. The any future resolves if any of

	the futures in aCollection resolves. The value given to the success handler is the

	value of the future that resolved. "

	| future |

	future := self new.

	aCollection do: [ :each | 

		each onSuccessDo: [ :value | 

			"At the moment just ignore every running future if the any has been resolved"

			future isFinished ifFalse: [  

				future deploySuccess: value  ] ].

		each onFailureDo: [ :fail | 

			future isFinished ifFalse: [

				future deployFailure: fail ] ] ].

	^ future
]
