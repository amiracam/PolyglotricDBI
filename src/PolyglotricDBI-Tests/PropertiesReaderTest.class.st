"
A PropertiesReaderTest is a test class for testing the behavior of PropertiesReader
"
Class {
	#name : #PropertiesReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'prop'
	],
	#category : #'PolyglotricDBI-Tests-Utilities'
}

{ #category : #running }
PropertiesReaderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	| string |
	
	string := '
	# this is a comment
	key1=charles
	key2=tanzi
	'.
	
	prop := PropertiesReader readFromString: string commentPrefix: '#'.

]

{ #category : #tests }
PropertiesReaderTest >> testInstanceCreation [ 

	self assert: prop isLoaded.
	
]

{ #category : #tests }
PropertiesReaderTest >> testKeyAccess [
	
	self assert: prop key1 equals: 'charles'
]

{ #category : #tests }
PropertiesReaderTest >> testModificationProtection [
	
	self should: [prop data: Dictionary new] raise: ModificationForbidden 
]

{ #category : #tests }
PropertiesReaderTest >> testReadingTradeblazerCT [
	
	| ct |
	ct := PropertiesReader readFrom: './tb_home/appServices/environ/SSS.CT'.
	self assert: ct TB_INST equals: 'SSS'.
	self assert: ct tb_inst equals: 'SSS'
]
