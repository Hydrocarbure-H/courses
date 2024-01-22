# We create a words list with the following command : crunch 7 7 abcdefgijklmnopqrstuvwxyz

# The function size compares two words character by character
# to determine if a character at the same position is identical.
def size(word, world):
    if (len(word) != len(world)):
        return 0
    for i in range(len(word)):
        if (word[i] == world[i]):
            return 0
    return 1

# A list called "output_words" will be used to store words from the "output2.txt" file.
output_words = []
filename = "output2.txt"
with open(filename, 'r') as file:
    for line in file:
        line = line.strip()  # Remove leading and trailing spaces
        output_words.append(line)

# Two given ciphertext words that you want to compare with other ciphertext words.
w1 = "HQQYAJT"
w2 = "RJAJPWG"

# The "diff" function calculates the character difference between two ciphertext words.
def diff(word, world):
    diff = ""
    for i in range(len(word)):
        if (ord(word[i]) > ord(world[i])):
            diff += chr(ord('A') + ord(word[i]) - ord(world[i]))
        else:
            diff += chr(ord('A') + ord(word[i]) - ord(world[i]) + 26)
    return diff

# Calculate the character difference between the two given words.
char_diff = diff(w1, w2)

# Iterate through the ciphertext words stored in "output_words" and search for pairs of words
# that have the same character difference as the given pair of words "HQQYAJT" and "RJAJPWG"
# while having at least one character in the same position.
# Issue : n2 complexity !
for i in range(len(output_words)):
    for j in range(i, len(output_words)):
        if diff(output_words[i], output_words[j]) == char_diff and size(output_words[i], output_words[j]):
            print(output_words[i], output_words[j])
            exit(1)
