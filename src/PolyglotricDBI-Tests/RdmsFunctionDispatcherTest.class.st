"
A RdmsFunctionDispatcherTest is a test class for testing the behavior of RdmsFunctionDispatcher
"
Class {
	#name : #RdmsFunctionDispatcherTest,
	#superclass : #TestCase,
	#instVars : [
		'functionDispatcher'
	],
	#category : #'PolyglotricDBI-Tests-Services'
}

{ #category : #running }
RdmsFunctionDispatcherTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	functionDispatcher := TBFunctionDispatcher new.

]
