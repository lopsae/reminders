#! /usr/bin/env python3

import re

alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".lower()

letters = []
for letter in alphabet:
	letters.append(letter)

tabula = []
for shift in range(len(letters)):
	shiftedLetters = []
	for index in range(len(letters)):
		shiftedIndex = (shift + index) % len(letters)
		letter = letters[shiftedIndex]
		shiftedLetters.append(letter)

	tabula.append(shiftedLetters)


cypher = "tuccnimechlxbguhvpesyvbsuxihryccmcptwkxcfmbpemvjvhahxdwvqmbrfwfkkiiwbivplvogiyeelwalvjmvaewdiibeexbvrtotewrkecbxrfuukepjgjsfjkaxdmcztbafmnqfstfkbtnxkmssurna"

keys = "Any attempts to sabotage, disrupt, delay, repurpose, alter, or otherwise interfere with the operations of the aforementioned transport, regardless of whether or not said sabotage, disruption, delay, repurposing, alteration, or interference is within the bounds of the signatory State or any other State, including both signatories and non-signatories, shall incur a penalty commensurate with the number of preceding penalties already incurred, according to the chart of Appendix B, and as determined by an impartial vote of representatives of all signatory States."

keys = re.sub("[^a-z]", "", keys.lower())

decodedLetters = []

for index, letter in enumerate(cypher):
	keyLetterIndex = letters.index(keys[index])
	shiftedAlph = tabula[keyLetterIndex]

	cypherLetterIndex = shiftedAlph.index(letter)
	decodedLetters.append(letters[cypherLetterIndex])

	# print(index, letter, keys[index], shiftedAlph[cypherLetterIndex], "".join(shiftedAlph))

print("".join(decodedLetters))

