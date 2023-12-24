#ifndef GAMEBACKEND_H
#define GAMEBACKEND_H

#include <QObject>
#include <QList>
#include <iostream>
#include <ctime>
#include <cstdlib>
#include <string>
using namespace std;

class Gamebackend : public QObject
{
    Q_OBJECT
public:
    explicit Gamebackend(QObject *parent = nullptr);



    const int TOTAL_CARDS = 40;
    const int CARDS_PER_PLAYER = 3;
    const int CARDS_ON_TABLE = 4;

    Q_INVOKABLE void distributeCards(QList<QString>& player1Hand, QList<QString>& player2Hand, QList<QString>& tableCards);

    Q_INVOKABLE bool addToTable(QString card, QList<QString>& tableCards, QList<QString>& playerHand);

    QString player1Hand;
    QString player2Hand;




signals:
};

#endif // GAMEBACKEND_H
