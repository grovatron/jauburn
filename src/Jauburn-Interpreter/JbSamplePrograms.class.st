"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> sqrt [ 
	^ 'var num = stringToNumber(input("Enter a positive integer"));
		var guess = num;
		var precision = 1 / 1000000000;
		var x = guess * guess;
		var condition = abs(num - x) > precision;
		while (condition) {
			println(concat("Incorrect guess: ", guess));
			var y = num / guess;
			var z = num + y;
			guess = z / 2;
		}
		println(concat("Answer: ", guess);'
]
