Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'bodyStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> bodyStatements [
	^ bodyStatements
]

{ #category : #accessing }
JbWhileLoopNode >> bodyStatements: anObject [
	bodyStatements := anObject
]

{ #category : #accessing }
JbWhileLoopNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbWhileLoopNode >> executeIn: environment [ 
	[ condition evaluateIn: environment ] whileTrue:
		[ bodyStatements do: [ :each | each executeIn: environment ] ]
]
