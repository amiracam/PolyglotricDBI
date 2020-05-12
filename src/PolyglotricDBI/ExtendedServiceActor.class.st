Class {
	#name : #ExtendedServiceActor,
	#superclass : #ExtendedService,
	#traits : 'TKTActorBehaviour',
	#classTraits : 'TKTActorBehaviour classTrait',
	#category : #'PolyglotricDBI-Actors'
}

{ #category : #accessing }
ExtendedServiceActor >> serviceRegistration [
	^ self actor
]
