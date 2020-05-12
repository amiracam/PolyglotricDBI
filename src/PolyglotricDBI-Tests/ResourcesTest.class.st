"
A ResourcesTest is a test class for testing the behavior of Resources
"
Class {
	#name : #ResourcesTest,
	#superclass : #TestCase,
	#instVars : [
		'resource'
	],
	#category : #'PolyglotricDBI-Tests-Commands'
}

{ #category : #running }
ResourcesTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	resource := Resources inst: 'SSS_P' home: './tb_home/appServices/bin'

]

{ #category : #testing }
ResourcesTest >> testInstanceCreation [ 
	self assert:	(resource configuration at: 'appName') equals: 'TblazeDBI'

	
]

{ #category : #testing }
ResourcesTest >> testLoadAppConfig [

" def test_load_app_config
    inst = @resource.application_configuration['TB_INST']
    assert_equal inst, 'SSS_P'
  end"

	self assert: (resource appConfiguration tb_inst) equals: resource clientInst.
]

{ #category : #testing }
ResourcesTest >> testLoadSysConfig [
"Ruby"
"def test_load_sys_config
    user = @resource.configuration.bootstrap_user
    assert_equal user, ADMIN1
  end"

	self assert: (resource configuration at: 'bootstrap_user' ) equals: 'ADMIN1'
]

{ #category : #testing }
ResourcesTest >> testUrlForUserPass [
	| url |
	
	url := resource connectionUrlFor: 'Charles' and: 'Tanzi'.
	self assert: url equals: 'jdbc:postgresql://192.168.40.107:5432/TEST_TBOSSS?user=Charles&password=Tanzi'
]
