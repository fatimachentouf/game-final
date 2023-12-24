#include "Gamebackend.h"

Gamebackend::Gamebackend(QObject *parent)
    : QObject{parent}
{}

void Gamebackend::distributeCards(QList<QString> &player1Hand, QList<QString> &player2Hand, QList<QString> &tableCards)
{
    // Créer un jeu de 40 cartes
    QList<QString> allCards;
    for (int i = 0; i < TOTAL_CARDS; ++i) {
        allCards.append("Card " + QString::number(i + 1));
    }

    // Mélanger les cartes en utilisant l'algorithme de Fisher-Yates
    srand(time(0));
    for (int i = TOTAL_CARDS - 1; i > 0; --i) {
        int j = rand() % (i + 1);
        allCards.swapItemsAt(i, j);
    }

    // Distribuer 3 cartes à chaque joueur
    for (int i = 0; i < CARDS_PER_PLAYER; ++i) {
        player1Hand.append(allCards[i]);
        player2Hand.append(allCards[i + CARDS_PER_PLAYER]);
    }

    // Distribuer 4 cartes sur la table
    for (int i = 0; i < CARDS_ON_TABLE; ++i) {
        tableCards.append(allCards[i + 2 * CARDS_PER_PLAYER]);
    }

}

bool Gamebackend::addToTable(QString card, QList<QString> &tableCards, QList<QString> &playerHand)
{
    int sum = 0;
    for (const auto& tableCard : tableCards) {
        sum += tableCard.mid(5).toInt(); // Extraire la valeur de la carte (suppose que la valeur est à la fin de la chaîne)
    }

    if (sum + card.mid(5).toInt() == 15) {
        cout << "Le joueur prend les cartes sur la table." << endl;
        // Vous pouvez ajouter ici la logique pour que le joueur prenne les cartes sur la table

        // Effacer la carte de la main du joueur
        playerHand.removeAll(card);

        return true;
    } else {
        cout << "La carte est ajoutée à la table." << endl;
                                                          // Vous pouvez ajouter ici la logique pour ajouter la carte à la table

                                                              // Effacer la carte de la main du joueur
                                                              playerHand.removeAll(card);

        return false;
    }
}
