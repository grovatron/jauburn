Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbsBinding [
	self interpret: 'var absNegativeTen = abs(-10); var absPositiveFive = abs(5);'.
	self assert: (interpreter environment at: 'absNegativeTen') equals: 10.
	self assert: (interpreter environment at: 'absPositiveFive') equals: 5
]

{ #category : #tests }
JbInterpreterTest >> testConcatBinding [
	self interpret: 'var x = concat("a", 1);'.
	self assert: (interpreter environment at: 'x') equals: 'a1'
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [
	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	self interpret: 'var a = 4; var b = a / 2;'.
	self assert: (interpreter environment at: 'b') equals: 2.
	self interpret: 'var c = 20; var d = c - 15;'.
	self assert: (interpreter environment at: 'd') equals: 5.
	self interpret: 'var q = 6; var p = -q;'.
	self assert: (interpreter environment at: 'p') equals: -6.
	self interpret: 'var isTrue = 3 == 3;'.
	self assert: (interpreter environment at: 'isTrue') equals: true.
	self interpret: 'var isFalse = 1 == 4;'.
	self assert: (interpreter environment at: 'isFalse') equals: false
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToFunction [
	self interpret: 'var f = function(x) {  return 2 * x; };'.
	self assert: (interpreter environment at: 'f') parameters size equals: 1.
	self assert: (interpreter environment at: 'f') parameters first identifier equals: 'x'.
	self assert: (interpreter environment at: 'f') body size equals: 1.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testEvaluatesBooleanExpressions [
	self interpret: 'var isTrue = 3 == 3;'.
	self assert: (interpreter environment at: 'isTrue') equals: true.
	self interpret: 'var isFalse = 1 == 4;'.
	self assert: (interpreter environment at: 'isFalse') equals: false.
	self interpret: 'var isLessThan = 1 < 100;'.
	self assert: (interpreter environment at: 'isLessThan') equals: true.
	self interpret: 'var isNotLessThan = 200 < 2;'.
	self assert: (interpreter environment at: 'isNotLessThan') equals: false.
	self interpret: 'var isLessThanOrEqual1 = 3 <= 300;'.
	self assert: (interpreter environment at: 'isLessThanOrEqual1') equals: true.
	self interpret: 'var isLessThanOrEqual2 = 4 <= 400;'.
	self assert: (interpreter environment at: 'isLessThanOrEqual2') equals: true.
	self interpret: 'var isNotLessThanOrEqual = 101 <= 100;'.
	self assert: (interpreter environment at: 'isNotLessThanOrEqual') equals: false.
	self interpret: 'var isGreaterThan = 5 > 2;'.
	self assert: (interpreter environment at: 'isGreaterThan') equals: true.
	self interpret: 'var isNotGreaterThan = 3 > 7;'.
	self assert: (interpreter environment at: 'isNotGreaterThan') equals: false.
	self interpret: 'var isGreaterThanOrEqual1 = 5 >= 4;'.
	self assert: (interpreter environment at: 'isGreaterThanOrEqual1') equals: true.
	self interpret: 'var isGreaterThanOrEqual2 = 33 >= 33;'.
	self assert: (interpreter environment at: 'isGreaterThanOrEqual2') equals: true.
	self interpret: 'var isNotGreaterThanOrEqual = 44 >= 45;'.
	self assert: (interpreter environment at: 'isNotGreaterThanOrEqual') equals: false.
	self interpret: 'var isNotEqual = 1 != 2;'.
	self assert: (interpreter environment at: 'isNotEqual') equals: true.
	self interpret: 'var isEqual = 3 != 3;'.
	self assert: (interpreter environment at: 'isEqual') equals: false
]

{ #category : #tests }
JbInterpreterTest >> testEvaluatesFunctionCall [
	
	self interpret: 'var plus5 = function (x) { return x + 5; }; var a = plus5(5);'.
	self assert: (interpreter environment at: 'a') equals: 10
]

{ #category : #tests }
JbInterpreterTest >> testLengthBinding [
	self interpret: 'var x = length("hello");'.
	self assert: (interpreter environment at: 'x') equals: 5
]

{ #category : #tests }
JbInterpreterTest >> testModBinding [
	self interpret: 'var tenModTwo = mod(10, 2); var tenModThree = mod(10, 3);'.
	self assert: (interpreter environment at: 'tenModTwo') equals: 0.
	self assert: (interpreter environment at: 'tenModThree') equals: 1
]

{ #category : #tests }
JbInterpreterTest >> testNotBinding [
	self interpret: 'var notTrue = not(true); var notFalse = not(false);'.
	self assert: (interpreter environment at: 'notTrue') equals: false.
	self assert: (interpreter environment at: 'notFalse') equals: true
]

{ #category : #tests }
JbInterpreterTest >> testPrintBinding [
	| mt |
	mt := JbMockTranscript new.
	interpreter transcript: mt.
	self interpret: 'print("Hello, World!");'.
	self assert: mt content equals: '''Hello, World!'''.
]

{ #category : #tests }
JbInterpreterTest >> testPrintlnBinding [
	| mt |
	mt := JbMockTranscript new.
	interpreter transcript: mt.
	self interpret: 'println("Goodbye, World!");'.
	self assert: mt content equals: '''Goodbye, World!'''
]

{ #category : #tests }
JbInterpreterTest >> testStringToNumberBinding [
	self interpret: 'var x = stringToNumber("10");'.
	self assert: (interpreter environment at: 'x') equals: 10
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoop [
	self interpret: 'var sum = 0; var x = 1; while (x <= 10) { sum = sum + x; x = x + 1; }'.
	self assert: (interpreter environment at: 'sum') equals: 55
]
