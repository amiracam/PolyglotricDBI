"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPolyglotricDBITests,
	#superclass : #PackageManifest,
	#category : #'PolyglotricDBI-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestPolyglotricDBITests class >> ruleRBGlobalVariablesUsageV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#APITest #testJsonConversion #false)) #'2020-04-03T15:37:35.515738-04:00') )
]

{ #category : #'code-critics' }
ManifestPolyglotricDBITests class >> ruleRBSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PropertiesReaderTest)) #'2020-04-22T12:13:31.386245-04:00') )
]

{ #category : #'code-critics' }
ManifestPolyglotricDBITests class >> ruleRBUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PropertiesReaderTest)) #'2020-04-22T12:13:36.85816-04:00') )
]
