Class {
	#name : #DBIService,
	#superclass : #HttpService,
	#category : #'PolyglotricDBI-Services'
}

{ #category : #'initailize-release' }
DBIService >> initializeRoutes [

	super initializeRoutes.
	
	server 
		POST: '/runProc' -> [:request |  self runProcedure: request ]
	
]

{ #category : #routes }
DBIService >> runProcedure: request [

	| httpRequest msgPackage dict |
	self logInfo: 'I HttpService received connect request'.
	msgPackage := request contents asJson.
	msgPackage at: #selector put: #runProcedure:.
	
	 self
		send: msgPackage
		to: #TBFunctionDispatcher
		from: self.

	^ ZnResponse new
		statusLine: ZnStatusLine ok;
		entity: (ZnEntity json: (NeoJSONWriter toString: dict));
		yourself.
]
