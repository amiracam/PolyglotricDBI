Class {
	#name : #Resources,
	#superclass : #Object,
	#traits : 'Configurable + Loggable',
	#classTraits : 'Configurable classTrait + Loggable classTrait',
	#instVars : [
		'clientInst',
		'home',
		'appConfiguration',
		'bootTime',
		'dbBroker'
	],
	#classVars : [
		'DbTypes'
	],
	#category : #'PolyglotricDBI-Commands'
}

{ #category : #acccessing }
Resources class >> dbTypes [
	^ DbTypes ifNil: [ self initializeDbTypes ].
]

{ #category : #initialization }
Resources class >> initializeDbTypes [
	"self initializeDbTypes"

	DbTypes := Dictionary new.
	
	^ DbTypes
		at: #oracle put: 'oracle';
		at: #ora put: 'oracle';
		at: #orat put: 'oracle';
		at: #postgresql put: 'postgresql';
		at: #pg put: 'postgresql';
		at: #pgc put: 'postgresql';
		yourself
]

{ #category : #initialization }
Resources class >> inititalize [
	self initializeDbTypes.
]

{ #category : #'instance creation' }
Resources class >> inst: clientMoniker home: homePath [ 

	^ (self basicNew)
		clientInst: clientMoniker ;
		home: homePath;
		initialize;
		beReadOnlyObject;
		yourself 
]

{ #category : #'instance creation' }
Resources class >> new [ 
	self shouldNotImplement 
]

{ #category : #accessing }
Resources >> appConfiguration [
	^ appConfiguration
]

{ #category : #accessing }
Resources >> appConfiguration: anObject [
	appConfiguration := anObject
]

{ #category : #accessing }
Resources >> bootTime [
	^ bootTime
]

{ #category : #accessing }
Resources >> bootTime: anObject [
	bootTime := anObject
]

{ #category : #accessing }
Resources >> clientInst [
	^ clientInst
]

{ #category : #accessing }
Resources >> clientInst: anObject [
	clientInst := anObject
]

{ #category : #'name resolutions' }
Resources >> connectionUrlFor: user and: password [
	"Return String"

	| dbType |
	
	dbType := self resolveDbTypeFor: self currentDatabaseType.

	^ self
		perform: dbType asSymbol
		withArguments: {user. password }.
]

{ #category : #'name resolutions' }
Resources >> currentDatabaseType [
	^ self appConfiguration db_type.
]

{ #category : #accessing }
Resources >> dbBroker [
	^ dbBroker
]

{ #category : #accessing }
Resources >> dbBroker: anObject [
	dbBroker := anObject
]

{ #category : #initialization }
Resources >> defaultLogFileName [
	^ (configuration  at: 'appName'),'_', appConfiguration tb_envt,'_',clientInst
]

{ #category : #initialization }
Resources >> externalConfigPath [
	^ home , '/../environ/', clientInst ,'.ct'


]

{ #category : #accessing }
Resources >> home [
	^ home
]

{ #category : #accessing }
Resources >> home: anObject [
	home := self enforceUnixPath: anObject .
]

{ #category : #initialization }
Resources >> initialize [

	self loadConfiguration.
	bootTime := Time now.
	self initializeDatabaseBrokers.
	self loadExternalConfig.
	self initializeLogger.
	self
		logInfo:
			('Tradeblazer DBI Service booting up for : #{1}' format: {clientInst.}).
]

{ #category : #initialization }
Resources >> initializeDatabaseBrokers [
	| broker |
	(broker := configuration at: #databaseBroker ifAbsent: [  ])
		ifNotNil: [ dbBroker := Smalltalk at: broker asSymbol ].
]

{ #category : #initialization }
Resources >> loadExternalConfig [

	appConfiguration := PropertiesReader readFrom: self externalConfigPath 
]

{ #category : #initialization }
Resources >> logFolder [
	"protect against empty home or enforce default"
	
	^ home , '/', (self enforceUnixPath: (appConfiguration log_dir))
]

{ #category : #accessing }
Resources >> logger [
	^ logger
]

{ #category : #accessing }
Resources >> logger: anObject [
	logger := anObject
]

{ #category : #'name resolutions' }
Resources >> resolveDbTypeFor: dbMoniker [
	" def resolve_db_type name:
      
      token = name.downcase
      case token
        when 'oracle', 'ora', 'orat'
          'oracle'
        when 'postgresql', 'pg', 'pgc'
          'postgresql'
        else
          raise Error: Not a valid db type: #{name}
      end
    
    end"

	^ DbTypes at: dbMoniker ifAbsent:[].
]
