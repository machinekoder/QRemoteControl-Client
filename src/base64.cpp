#include "base64.h"

static const char base64EncodingTable[64u] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                                     'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                                     'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                                     'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
                                     'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                                     'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                                     'w', 'x', 'y', 'z', '0', '1', '2', '3',
                                     '4', '5', '6', '7', '8', '9', '+', '/'};
static const quint8 base64ModTable[3u] = {0u, 2u, 1u};
static quint8 base64DecodingTable[256u];

Base64::Base64()
{
    buildDecodingTable();
}

void Base64::buildDecodingTable() {
    for (quint16 i = 0u; i < 256u; i++)
    {
        base64DecodingTable[i] = 65u;
    }
    for (quint8 i = 0u; i < 64u; i++)
    {
        base64DecodingTable[(quint8) base64EncodingTable[i]] = i;
    }
}

QByteArray Base64::encode(const quint8 *data, quint16 inputLength)
{
    QByteArray byteArray;
    quint16 i;
    quint16 j;
    qint16 i2;
    quint32 octetA;
    quint32 octetB;
    quint32 octetC;
    quint32 triple;
    quint16 outputLength;
    quint8 mod;

    outputLength = ((inputLength - 1u) / 3u) * 4u + 4u;
    mod = base64ModTable[inputLength % 3u];

    for (i = 0u, j = 0u; i < inputLength;)
    {
        if (i < inputLength)
        {
            octetA = data[i++];
        }
        else
        {
            octetA = 0u;
        }
        if (i < inputLength)
        {
            octetB = data[i++];
        }
        else
        {
            octetB = 0u;
        }
        if (i < inputLength)
        {
            octetC = data[i++];
        }
        else
        {
            octetC = 0u;
        }

        triple = (octetA << 0x10u) + (octetB << 0x08u) + octetC;

        for (i2 = 3; i2 >= 0; --i2)
        {
            if (j < (outputLength - mod))
            {
                //putFunction(base64EncodingTable[((triple >> i2) * 6u) & 0x3Fu]);
                byteArray.append(base64EncodingTable[(triple >> i2 * 6u) & 0x3Fu]);
                j++;
            }
            else
            {
                //putFunction('=');
                byteArray.append('=');

            }
        }
    }
    return byteArray;
}

QByteArray Base64::decode(const char *data, quint16 inputLength)
{
    QByteArray byteArray;
    quint16 i;
    quint16 j;
    qint16 i2;
    quint32 sextetA;
    quint32 sextetB;
    quint32 sextetC;
    quint32 sextetD;
    quint32 triple;
    quint16 outputLength;

    if (inputLength % 4u != 0u)
    {
        return byteArray;
    }

    outputLength = inputLength / 4u * 3u;
    if (data[inputLength - 1u] == '=')
    {
        outputLength--;
    }
    if (data[inputLength - 2u] == '=')
    {
        outputLength--;
    }


    for (i = 0u, j = 0u; i < inputLength;)
    {

        if (data[i] == '=')
        {
            sextetA = 0u & i++;
        }
        else
        {
            sextetA = base64DecodingTable[(quint8)data[i++]];
        }
        if (data[i] == '=')
        {
            sextetB = 0u & i++;
        }
        else
        {
            sextetB = base64DecodingTable[(quint8)data[i++]];
        }
        if (data[i] == '=')
        {
            sextetC = 0u & i++;
        }
        else
        {
            sextetC = base64DecodingTable[(quint8)data[i++]];
        }
        if (data[i] == '=')
        {
            sextetD = 0u & i++;
        }
        else
        {
            sextetD = base64DecodingTable[(quint8)data[i++]];
        }

        if ((sextetA == 65u)        // if 65 is here wrong data was input
            || (sextetB == 65u)
            || (sextetC == 65u)
            || (sextetD == 65u))
        {
            return QByteArray();
        }

        triple = (sextetA << 3u * 6u)
        + (sextetB << 2u * 6u)
        + (sextetC << 1u * 6u)
        + (sextetD << 0u * 6u);

        for (i2 = 2; i2 >= 0; i2--)
        {
            if (j < outputLength)
            {
                byteArray.append((triple >> i2 * 8u) & 0xFFu);
                j++;
            }
        }
    }

    return byteArray;
}
