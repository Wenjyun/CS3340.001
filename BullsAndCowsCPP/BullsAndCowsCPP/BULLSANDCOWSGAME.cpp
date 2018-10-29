#include <iostream>
#include <iomanip>
#include <string>
#include <cstdlib>
#include <ctime>

using namespace std;

void displayMainMenu();
bool validInput(string);
int findBulls(string, string);
int findCows(string, string);
void quitMenu(string, int);
bool checkWinner(int);
string getInput();

string words[] = { "girl", "calf", "verb", "duck" };

int main()
{
    srand(time(NULL));
    string word = words[rand() % 4];
    string guess;
    int numTries = 1;
    int input = 1;
    int bulls = 0;
    int cows = 0;

    while (input != 0){
        displayMainMenu();
        cin >> input;
        cout << endl;
        if (input == 0){
            continue;
        }
        while (numTries <= 10 && guess != "QUIT"){
            guess = getInput();
            cout << endl;
            if (guess == "QUIT"){
                quitMenu(word, numTries);
                break;
            }
            bulls = findBulls(word, guess);
            cows = findCows(word, guess);
            cows -= bulls;
            if (checkWinner(bulls)){
                cout << "YOU WON" << endl << endl;
                break;
            }

            cout << "GUESS" << setw(10) << "BULLS" << setw(10) << "COWS" << setw(10) << "ATTEMPT" << endl;
            cout << guess << setw(10) << bulls << setw(10) << cows << setw(10) << numTries << endl << endl;


            numTries++;
        }
        if (numTries >= 11){
            quitMenu(word, numTries);
        }


    }



    return 0;
}

void displayMainMenu()
{
    cout << "*******************" << endl;
    cout << "BULLS AND COWS GAME" << endl;
    cout << "*******************" << endl << endl;

    cout << "PRESS 1 TO CONTINUE OR 0 TO EXIT" << endl;

}

string getInput(){
    string guess;
    cout << "ENTER YOUR GUESS OF THE 4-LETTER WORD: " << endl;
    cout << "ENTER QUIT IF YOU WANT TO GIVE UP" << endl;
    cin >> guess;

    while (!validInput(guess)){
        cout << "YOUR GUESS WAS INVALID ENTER ANOTHER GUESS: ";
        cin >> guess;
    }

    return guess;
}

bool validInput(string guess)
{

    if (guess.size() != 4)
        return false;
    else
    {
        for (int i = 0; i < 4; i++)
        {
            for (int j = 3; j > 0; j--)
            {
                if (i == j)
                    continue;
                else if (guess[i] == guess[j])
                    return false;
            }
            //if (!isupper(guess[i]))
              //  return false;
        }
    }

    return true;

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

bool checkWinner(int bulls)
{
    if (bulls == 4)
    {
        return true;
    }
    else
        return false;
}

void quitMenu(string word, int numTries)
{
    if (numTries != 11){
        cout << "YOU GAVE UP!" << endl;
        cout << "SECRET WORD: " << word << endl << endl;
    }
    else{
        cout << "YOU RAN OUT OF ATTEMPTS" << endl;
        cout << "SECRET WORD: " << word << endl << endl;
    }
}



