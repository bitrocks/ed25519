#include "ed25519.h"
#include "sha512.h"
#include "ge.h"
#include <string.h>


int ed25519_create_keypair(unsigned char *public_key, unsigned char *private_key, const unsigned char *seed) {
    ge_p3 A;
    SHA512_HASH hash;
    unsigned char digest[32];
    Sha512Calculate(seed, 32, &hash);
    for(int i=0;i<32;i++) {
        digest[i] = hash.bytes[i];
    }
    digest[0] &= 248;
    digest[31] &= 127;
    digest[31] |= 64;

    ge_scalarmult_base(&A, digest);
    ge_p3_tobytes(public_key, &A);
    memmove(private_key, seed, 32);
    memmove(private_key + 32, public_key, 32);
    return 0;

}

int ed25519_public_key(unsigned char *public_key, unsigned char *private_key)
{
    ge_p3 A;
    ge_scalarmult_base(&A, private_key);
    ge_p3_tobytes(public_key, &A);
    return 0;
}

