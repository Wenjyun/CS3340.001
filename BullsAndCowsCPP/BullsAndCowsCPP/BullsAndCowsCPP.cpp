// BullsAndCowsCPP.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "stdio.h"
#include <ctime>
#include <iostream>
#include <string>
#include <cstdlib>

using namespace std;

void OneGame(string word);

// Array of words for the player to be able to guess
string words[] = { "girl", "calf", "verb", "duck" };

int main()
{
	// Get a random word from the array and send it to the main game function
	srand(time(NULL));
	OneGame(words[rand() % 4]);

    return 0;
}

void OneGame(string word)
{
	// Display main menu

	// Prompt user for input and tell them how to exit the game (enter -1)
	string guess;
	cout << "Enter your guess: ";
	cin >> guess;
	cout << "You entered: " << guess << endl;
}