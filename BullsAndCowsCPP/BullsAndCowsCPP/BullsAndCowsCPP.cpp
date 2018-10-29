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

// Number of guesses the player has until they lose
int MaxGuesses = 6;

int main()
{
	// Get a random word from the array and send it to the main game function
	srand(time(NULL));
	OneGame(words[rand() % 4]);

    return 0;
}

void OneGame(string word)
{
	int NumberOfGuesses = 0;

	while (NumberOfGuesses < MaxGuesses)
	{
		// Display main menu

		// Prompt user for input and tell them how to exit the game (enter -1)
		string guess;
		cout << "Enter your guess (Enter -1 to exit the game): ";
		cin >> guess;

		// Check if they entered -1

		// Check if the input is invalid and send back to input prompt if it is

		// Count number of bulls
		int bulls = findBulls(word, guess);

		// Counter number of cows
		int cows = findCows(word, guess);

		// Remove the false cows that are actually bulls
		cows -= bulls;

		// Display number of bulls and cows

		// Check if the player has won using a function

		// If they did win, return and exit this function
	}	
}

int findBulls(string secret, string guess)
{
    int bulls = 0;
    for (int i = 0; i < 4; i++)
    {
        if (secret[i] == guess[i])
            bulls++;
    }

    return bulls;
}

int findCows(string secret, string guess)
{
    int cows = 0;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            if (secret[i] == guess[j])
                cows++;
        }
    }

    return cows;
}
