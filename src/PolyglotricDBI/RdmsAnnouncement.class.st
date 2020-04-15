Class {
	#name : #RdmsAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'timestamp',
		'session',
		'error'
	],
	#category : #'PolyglotricDBI-Announcements'
}

{ #category : #accessing }
RdmsAnnouncement >> error [
	^ error
]

{ #category : #accessing }
RdmsAnnouncement >> error: anObject [
	error := anObject
]

{ #category : #initialization }
RdmsAnnouncement >> initialize [ 
	timestamp := DateAndTime now.
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
