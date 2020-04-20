"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPolyglotricDBI,
	#superclass : #PackageManifest,
	#category : #'PolyglotricDBI-Manifest'
}

{ #category : #'code-critics' }
ManifestPolyglotricDBI class >> ruleRBSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TBUserManagement #processUPW #false)) #'2020-04-17T18:35:37.739644-04:00') )
]

{ #category : #'code-critics' }
ManifestPolyglotricDBI class >> ruleRBUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TBUserManagement #processUPW #false)) #'2020-04-17T18:34:59.928274-04:00') #(#(#RGMethodDefinition #(#HttpService #initializeRoutes #false)) #'2020-04-18T13:36:10.956564-04:00') )
]
