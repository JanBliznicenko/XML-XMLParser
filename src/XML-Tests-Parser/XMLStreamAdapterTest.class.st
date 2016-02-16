Class {
	#name : #XMLStreamAdapterTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF16BE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: 0 asCharacter;
				nextPut: each]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF16LE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: each;
				nextPut: 0 asCharacter]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF32BE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: each]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF32LE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: each;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter]]
]

{ #category : #testing }
XMLStreamAdapterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #converting }
XMLStreamAdapterTest class >> stringFrom: aCollection [
	"avoid asString for portability"
	^ String withAll: (aCollection collect: [:each | each asCharacter])
]

{ #category : #accessing }
XMLStreamAdapterTest >> adapterClass [
	^ XMLStreamAdapter
]

{ #category : #converting }
XMLStreamAdapterTest >> asciiToUTF16BE: anASCIIString [
	^ self class asciiToUTF16BE: anASCIIString
]

{ #category : #converting }
XMLStreamAdapterTest >> asciiToUTF16LE: anASCIIString [
	^ self class asciiToUTF16LE: anASCIIString
]

{ #category : #converting }
XMLStreamAdapterTest >> asciiToUTF32BE: anASCIIString [
	^ self class asciiToUTF32BE: anASCIIString
]

{ #category : #converting }
XMLStreamAdapterTest >> asciiToUTF32LE: anASCIIString [
	^ self class asciiToUTF32LE: anASCIIString
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF16String [
	^ self stringFrom:
		#(16rFF 16r0100 16rD7FF 16rE000 16rFFFF 16r10000 16r10437 16r24B62 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF32String [
	^ self stringFrom: #(16rFE 16rD7FE 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF8String [
	^ self stringFrom:
		#(16r7F 16r80 16r7FF 16r800 16rFFFF 16r10000 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF16BEString [
	^ self stringFrom:
		#(16r00 16rFF
			16r01 16r00
			16rD7 16rFF
			16rE0 16r00
			16rFF 16rFF
			16rD8 16r00 16rDC 16r00 "first surrogate pair"
			16rD8 16r01 16rDC 16r37
			16rD8 16r52 16rDF 16r62
			16rDB 16rFF 16rDF 16rFF) "last surrogate pair"
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF16LEString [
	^ self stringFrom:
		#(16rFF 16r00
			16r00 16r01
			16rFF 16rD7
			16r00 16rE0
			16rFF 16rFF
			16r00 16rD8 16r00 16rDC "first surrogate pair"
			16r01 16rD8 16r37 16rDC
			16r52 16rD8 16r62 16rDF
			16rFF 16rDB 16rFF 16rDF) "last surrogate pair"
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF32BEString [
	^ self stringFrom:
		#(16r00 16r00 16r00 16rFE
			16r00 16r00 16rD7 16rFE
			16r00 16r10 16rFF 16rFF)
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF32LEString [
	^ self stringFrom:
		#(16rFE 16r00 16r00 16r00
			16rFE 16rD7 16r00 16r00
			16rFF 16rFF 16r10 16r00)
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF8String [
	^ self stringFrom:
		#(16r7F
			16rC2 16r80
			16rDF 16rBF
			16rE0 16rA0 16r80
			16rEF 16rBF 16rBF
			16rF0 16r90 16r80 16r80
			16rF4 16r8F 16rBF 16rBF)
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newAdapter [
	^ self newAdapterOn: self newStream
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newAdapterOn: aStream [
	^ self adapterClass on: aStream
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStream [
	^ self newStreamOn: self streamCollection
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStreamOn: aCollection [
	^ self streamClass on: aCollection
]

{ #category : #converting }
XMLStreamAdapterTest >> percentEncode: aCharacter [
	| hexString |

	(hexString := aCharacter asciiValue printStringHex asUppercase) size > 1
		ifTrue: [^ '%', hexString]
		ifFalse: [^ '%0', hexString]
]

{ #category : #accessing }
XMLStreamAdapterTest >> percentEncodedUTF8String [
	^ String streamContents: [:stream |
		self encodedUTF8String do: [:each |
			stream nextPutAll: (self percentEncode: each)]]
]

{ #category : #accessing }
XMLStreamAdapterTest >> streamClass [
	^ ReadStream
]

{ #category : #accessing }
XMLStreamAdapterTest >> streamCollection [
	^ String new
]

{ #category : #converting }
XMLStreamAdapterTest >> stringFrom: aCollection [
	^ self class stringFrom: aCollection
]

{ #category : #tests }
XMLStreamAdapterTest >> testClose [
	self
		shouldnt: [self newAdapter close]
		raise: Error
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsBinary [
	self deny: self newAdapter isBinary
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsConvertingStreamAdapter [
	self deny: self newAdapter isConvertingStreamAdapter
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsStream [
	self assert: self newAdapter isStream
]