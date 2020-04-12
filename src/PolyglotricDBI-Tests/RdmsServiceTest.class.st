"
A RdmsServiceTest is a test class for testing the behavior of RdmsService
"
Class {
	#name : #RdmsServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'rdmsService'
	],
	#category : #'PolyglotricDBI-Tests-Services'
}

{ #category : #acccessing }
RdmsServiceTest >> connectionPoolFactory [
	^ P3ConnectionPool
]

{ #category : #acccessing }
RdmsServiceTest >> serverUrl [
	^'psql://TEST_TBOSSS_ADMIN1:ADMIN1@192.168.40.107:5432/TEST_TBOSSS'
]

{ #category : #running }
RdmsServiceTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	| client |
	super setUp.
	rdmsService := RdmsService new.
	
]

{ #category : #testing }
RdmsServiceTest >> testBeginTransaction [
	""

	rdmsService client
		withConnection: [ :c | 
			c
				inTransaction: [ :ctx | 
					ctx
						execute: 'DROP TABLE IF EXISTS table2';
						execute: 'CREATE TABLE table2 (id INTEGER, name TEXT, enabled BOOLEAN)';
						execute: 'INSERT INTO table2 (id, name, enabled) VALUES (1, ''foo'', true)';
						execute: 'INSERT INTO table2 (id, name, enabled) VALUES (2, ''bar'', false)'
					]
			].
]

{ #category : #testing }
RdmsServiceTest >> testBeginTransaction2 [
	"assumes begin 1 "

	rdmsService client
		withConnection: [ :c | 
			c execute: 'BEGIN'.
			
			c
				execute: 'INSERT INTO table1 (id, name, enabled) VALUES (30, ''foo2'', true)'.
			c
				execute: 'INSERT INTO table1 (id, name, enabled) VALUES (40, ''bar2'', false)'.
			c execute: 'COMMIT'
			].
]

{ #category : #testing }
RdmsServiceTest >> testRollbackTransaction [
	""

	rdmsService client
		withConnection: [ :c | 
			c execute: 'BEGIN'.
			
			c
				execute: 'INSERT INTO table1 (id, name, enabled) VALUES (300, ''foo23'', true)'.
			c
				execute: 'INSERT INTO table1 (id, name, enabled) VALUES (400, ''bar23'', false)'.
			c execute: 'ROLLBACK'
			].
]
