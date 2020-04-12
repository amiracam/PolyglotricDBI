"
A TBFunctionDispatcherTest is a test class for testing the behavior of TBFunctionDispatcher
"
Class {
	#name : #TBFunctionDispatcherTest,
	#superclass : #TestCase,
	#instVars : [
		'functionDispatcher'
	],
	#category : #'PolyglotricDBI-Tests-Services'
}

{ #category : #running }
TBFunctionDispatcherTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	functionDispatcher  := TBFunctionDispatcher new.

]

{ #category : #testing }
TBFunctionDispatcherTest >> testProcessFunction [
	"assumes begin 1 "

	| dict |
	self halt.
	dict := Dictionary new.

	dict
		at: #arraySize put: 1;
		at: #eventList put: 'TST77777|Tanzi|true|20200412'.

	functionDispatcher processFunction: dict.
]
