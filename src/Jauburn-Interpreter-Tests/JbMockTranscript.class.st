Class {
	#name : #JbMockTranscript,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #accessing }
JbMockTranscript >> content [ 
	^ content
]

{ #category : #'stop conditions' }
JbMockTranscript >> cr [
]

{ #category : #showing }
JbMockTranscript >> show: aString [
	content := aString
]
