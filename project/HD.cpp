#include <iostream>
#include <vector>

using namespace std;

int main() {

    vector<int> A;
    vector<int> B;
    vector<int> Cin;

    vector<int> S;
    S.resize( 8, 0 );
    vector<int> Cout;
    Cout.resize( 8, 0 );

    vector<int> correct_out;  // will need to push the correct output once, no need to do it more than that
                                // all the S's first then all the Cout
    vector<int> encrypt_out; // will need to remove this one

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
    results.resize(8,0);

    /* Holds the computation */
    vector<int> HD;
    HD.resize( 16, 0 );

    double Hamming_distance = 0;    //final result

    /* All these push statements will be removed */
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 0 );
    encrypt_out.push_back( 1 );
    encrypt_out.push_back( 0 );

    /* Nodes */
    int eight;
    int nine;
    int ten;
    int eleven;
    int twelve;
    int thirteen;
    int fifteen;

    /* All the possible inputs to the circuit */
    A.push_back( 0 );
    A.push_back( 0 );
    A.push_back( 0 );
    A.push_back( 0 );
    A.push_back( 1 );
    A.push_back( 1 );
    A.push_back( 1 );
    A.push_back( 1 );

    B.push_back( 0 );
    B.push_back( 0 );
    B.push_back( 1 );
    B.push_back( 1 );
    B.push_back( 0 );
    B.push_back( 0 );
    B.push_back( 1 );
    B.push_back( 1 );

    Cin.push_back( 0 );
    Cin.push_back( 1 );
    Cin.push_back( 0 );
    Cin.push_back( 1 );
    Cin.push_back( 0 );
    Cin.push_back( 1 );
    Cin.push_back( 0 );
    Cin.push_back( 1 );

    /* ------- The FULL ADDER ----------  */
    for ( int i = 0; i < 8; ++i ) {

        eight = A[i] ^ B[i];
        nine = A[i] & B[i];

        fifteen = eight & Cin[i];
        S[i] = eight ^ Cin[i];
        Cout[i] = fifteen | nine;

    }

    printf( "A    B    Cin    |    S    Cout\n\n" );
    for ( int j = 0; j < 8; ++j ) {
        printf( "%d    %d    %d    |    %d    %d\n", A[j], B[j], Cin[j], S[j], Cout[j] );
    }

    /* Fill correct output */
    for ( int k = 0; k < S.size(); ++k ) {
        correct_out.push_back( S[k] );
    }

    for ( int l = 0; l < Cout.size(); ++l ) {
        correct_out.push_back( Cout[l] );
    }
    //-----------------------------------------

    /* Calculated HD */
    for ( int m = 0; m < correct_out.size(); ++m ) {
        HD[m] = correct_out[m] - encrypt_out[m];
    }

    for ( int n = 0; n < HD.size(); ++n ) {
        if ( HD[n] == -1 ) HD[n] = 1;       // if 0 - 1 = -1, change to 1
        Hamming_distance += HD[n];          // add up the numbers
    }
    printf( "%f%%\n", ( Hamming_distance / 16 ) * 100 );    // average

    return 0;

}


