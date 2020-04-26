"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter >> absBinding [
	^#abs -> [ :num | num abs ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> concatBinding [
	^#concat -> [ :s1 :s2 | (s1 asString), (s2 asString) ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s |
			| binding primitive |
			binding := self perform: s.
			primitive := JbPrimitive new.
			primitive block: binding value.
			environment at: (binding key) put: primitive ]
	
]

{ #category : #'as yet unclassified' }
JbInterpreter >> inputBinding [
	^#input -> [ :prompt | (self uimanager) default request: prompt ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #'as yet unclassified' }
JbInterpreter >> lengthBinding [
	^#length -> [ :str | str size ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> modBinding [
	^#mod -> [ :a :b | a \\ b ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> notBinding [
	^#not -> [ :bool | bool not ]
]

{ #category : #binding }
JbInterpreter >> printBinding [
	^#print -> [ :s | (self transcript) show: s printString ]
]

{ #category : #binding }
JbInterpreter >> printlnBinding [
	^#println -> [ :s | (self transcript) show: s printString ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #'as yet unclassified' }
JbInterpreter >> stringToNumberBinding [
	^#stringToNumber -> [ :str | str asNumber ]
]

{ #category : #binding }
JbInterpreter >> transcript [
	^ transcript ifNil: [ Transcript ]
]

{ #category : #binding }
JbInterpreter >> transcript: aTranscript [
	transcript := aTranscript
]

{ #category : #accessing }
JbInterpreter >> uimanager [ 
	^ uimanager ifNil: [ UIManager ]
]

{ #category : #accessing }
JbInterpreter >> uimanager: aUIManager [
	uimanager := aUIManager 
]
