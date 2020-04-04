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
