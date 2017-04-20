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

    vector<int> correct_out;
    vector<int> encrypt_out;
    vector<int> HD;
    HD.resize( 16, 0 );

    double Hamming_distance = 0;

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

    int eight;
    int nine;
    int ten;
    int eleven;
    int twelve;
    int thirteen;
    int fifteen;


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

    for ( int m = 0; m < correct_out.size(); ++m ) {
        HD[m] = correct_out[m] - encrypt_out[m];

    }


    for ( int n = 0; n < HD.size(); ++n ) {
        if ( HD[n] == -1 ) HD[n] = 1;
        Hamming_distance += HD[n];

    }
    printf( "%f%%\n", ( Hamming_distance / 16 ) * 100 );

    return 0;

}


