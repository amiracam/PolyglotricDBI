"
A LoggerTest is a test class for testing the behavior of Logger
"
Class {
	#name : #LoggerTest,
	#superclass : #TestCase,
	#instVars : [
		'logger'
	],
	#category : #'PolyglotricDBI-Tests-Utilities'
}

{ #category : #accessing }
LoggerTest >> logger [
	^ logger
]

{ #category : #accessing }
LoggerTest >> logger: anObject [
	logger := anObject
]

{ #category : #running }
LoggerTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	logger := Logger new.
	logger 
		homeDir: './logs/';
		filename: 'test'

]

{ #category : #testing }
LoggerTest >> testCreation [ 

	self assert: logger filename equals: 'test'.
	self assert: logger homeDir  equals: './logs/'.
]

{ #category : #testing }
LoggerTest >> testWrite [

	self logger write: 'Hello there'
]
