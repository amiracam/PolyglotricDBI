Class {
	#name : #RdmsAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'timestamp',
		'session',
		'message'
	],
	#category : #'PolyglotricDBI-Announcements'
}

{ #category : #initialization }
RdmsAnnouncement >> initialize [ 
	timestamp := DateAndTime now.
]

{ #category : #accessing }
RdmsAnnouncement >> message [
	^ message
]

{ #category : #accessing }
RdmsAnnouncement >> message: anObject [
	message := anObject
]

{ #category : #accessing }
RdmsAnnouncement >> session [
	^ session
]

{ #category : #accessing }
RdmsAnnouncement >> session: anObject [
	session := anObject
]

{ #category : #accessing }
RdmsAnnouncement >> timestamp [
	^ timestamp
]

{ #category : #accessing }
RdmsAnnouncement >> timestamp: anObject [
	timestamp := anObject
]
