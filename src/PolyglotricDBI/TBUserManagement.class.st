Class {
	#name : #TBUserManagement,
	#superclass : #TBStoredProcedure,
	#category : #'PolyglotricDBI-Processing'
}

{ #category : #private }
TBUserManagement >> doesUserExist: user [
	| args |
	
	args := self
		executeSelectInto: ('SELECT COUNT(*) FROM tb_users WHERE user_id = {1}' format: {user.}).

	^ args first ~= 0.
]

{ #category : #processing }
TBUserManagement >> processUPW [
	| user |
	"ported from stored procedures"
	
	user := event user.

	(self doesUserExist: user)
		ifFalse: [ "what does a 100 mean ? "
			errorCode := 100.
			returnMsg := ''.
			logAction := ''.
			self logInfo.

			logAction := 'ADMIN USER: ' , user.
			logResult := 'NO SUCH USER IN DATABASE'.
			self logInfo
			]
		ifTrue: [ returnMsg := self retrievePasswordFor: user ].
]

{ #category : #queries }
TBUserManagement >> retrievePasswordFor: user [
	^ self
		executeSelectInto: ('SELECT password FROM tb_users WHERE user_id = {1}' format: {user.}).
]
