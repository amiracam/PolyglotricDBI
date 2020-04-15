"
A RdmsAnnouncementTest is a test class for testing the behavior of RdmsAnnouncement
"
Class {
	#name : #RdmsAnnouncementTest,
	#superclass : #TestCase,
	#instVars : [
		'announcer'
	],
	#category : #'PolyglotricDBI-Tests-Announcements'
}

{ #category : #running }
RdmsAnnouncementTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	announcer := Announcer new.
	announcer
		when: RdmsAnnouncement
		do: [ :event | 
			Transcript show: 'Received announcement';cr.
			Transcript
				show: event printString;
				cr
			].
]

{ #category : #tests }
RdmsAnnouncementTest >> testAnnouncement [

	announcer announce: (RdmsAnnouncement new error: 'my bad')
	
]
