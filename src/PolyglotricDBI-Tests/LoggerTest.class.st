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
		homeDir: './testLogs/';
		filename: 'test'

]

{ #category : #testing }
LoggerTest >> testBadPath [

	| badLogger |
	
	badLogger := Logger new.
	badLogger 
		homeDir: './../../../../badLogs/';
		filename: 'badLogger'.
		
	self should:[badLogger info: 'I should not get here'] raise: Exception 
		
	

]

{ #category : #testing }
LoggerTest >> testCreation [ 

	self assert: logger filename equals: 'test'.
	self assert: logger homeDir  equals: './logsxxx/'.
]

{ #category : #testing }
LoggerTest >> testWrite [

	self logger info: 'Hello there'
]
