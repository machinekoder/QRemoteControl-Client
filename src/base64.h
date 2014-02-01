#ifndef BASE64_H
#define BASE64_H

#include<QByteArray>

class Base64
{
public:
    Base64();
    QByteArray encode(const quint8 *data, quint16 inputLength);
    QByteArray decode(const char *data, quint16 inputLength);
private:
    void buildDecodingTable();
};

#endif // BASE64_H
