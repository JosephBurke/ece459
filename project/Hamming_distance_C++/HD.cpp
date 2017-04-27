#include <iostream>
#include <vector>

using namespace std;

int main() {

    vector<int> A;
    vector<int> B;
    vector<int> Cin;

    vector<int> S;
    S.resize(8, 0);
    vector<int> Cout;
    Cout.resize(8, 0);

    vector<int> correct_out;    // all the S's first then all the Cout

    /* Push the correct S */
    correct_out.push_back(0);
    correct_out.push_back(1);
    correct_out.push_back(1);
    correct_out.push_back(0);
    correct_out.push_back(1);
    correct_out.push_back(0);
    correct_out.push_back(0);
    correct_out.push_back(1);
    /* Push the correct Cout */
    correct_out.push_back(0);
    correct_out.push_back(0);
    correct_out.push_back(0);
    correct_out.push_back(1);
    correct_out.push_back(0);
    correct_out.push_back(1);
    correct_out.push_back(1);
    correct_out.push_back(1);




    /* Holds output for each case (not implement yet)*/
    vector<int> encrypt0;
    vector<int> encrypt1;
    vector<int> encrypt2;
    vector<int> encrypt3;
    vector<int> encrypt4;
    vector<int> encrypt5;
    vector<int> encrypt6;
    vector<int> encrypt7;

    /* Will hold all the results for the different HD */
    vector<double> results;
    results.resize(8, 0);

    /* Holds the computation */
    vector<int> HD;
    HD.resize(16, 0);

    double Hamming_distance = 0;    //final result


    /* Nodes */
    int eight;
    int nine;
    int ten;
    int eleven;
    int twelve;
    int thirteen;
    int fifteen;

    /* Key nodes */
    int key_gate_1;
    int key_gate_2;

    /* Key Switches */
    int SW15 = 1;       //correct 0
    int SW14 = 1;       // correct 1

    /* All the possible inputs to the circuit */
    A.push_back(0);
    A.push_back(0);
    A.push_back(0);
    A.push_back(0);
    A.push_back(1);
    A.push_back(1);
    A.push_back(1);
    A.push_back(1);

    B.push_back(0);
    B.push_back(0);
    B.push_back(1);
    B.push_back(1);
    B.push_back(0);
    B.push_back(0);
    B.push_back(1);
    B.push_back(1);

    Cin.push_back(0);
    Cin.push_back(1);
    Cin.push_back(0);
    Cin.push_back(1);
    Cin.push_back(0);
    Cin.push_back(1);
    Cin.push_back(0);
    Cin.push_back(1);

    /* ------- The Encrypt FULL ADDER ----------  */
    for (int i = 0; i < 8; ++i) {

        eight = A[i] ^ B[i];
        nine = A[i] & B[i];

        key_gate_1 = SW15 ^ eight;      // XOR gate
        key_gate_2 = !(SW14 ^ nine);    // XNOR gate


        fifteen = eight & Cin[i];
        S[i] = key_gate_1 ^ Cin[i];
        Cout[i] = fifteen | key_gate_2;

    }

    printf("A    B    Cin    |    S    Cout\n\n");
    for (int j = 0; j < 8; ++j) {
        printf("%d    %d    %d    |    %d    %d\n", A[j], B[j], Cin[j], S[j], Cout[j]);
    }

    /* Fill  output */
    for (int k = 0; k < S.size(); ++k) {
        encrypt0.push_back(S[k]);
    }

    for (int l = 0; l < Cout.size(); ++l) {
        encrypt0.push_back(Cout[l]);
    }
    //-----------------------------------------

    /* Calculated HD */
    for (int m = 0; m < correct_out.size(); ++m) {
        HD[m] = correct_out[m] - encrypt0[m];
    }

    for (int n = 0; n < HD.size(); ++n) {
        if (HD[n] == -1) HD[n] = 1;       // if 0 - 1 = -1, change to 1
        Hamming_distance += HD[n];          // add up the numbers
    }
    printf("%f%%\n", (Hamming_distance / 16) * 100);    // average

    return 0;

}


