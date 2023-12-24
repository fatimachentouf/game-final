import QtQuick 2.15
import QtQuick.Controls 2.15


ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 300
    title: "Quinza"

    Rectangle {
        id: main
        anchors.fill: parent
        width: window.width
        height: window.height
        color: "lightblue"

        Column {
            spacing: 20

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Quinza"
                font.pixelSize: 20
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "les regles:
Début
          A gauche,le stock des cartes
          Au milieu,les cartes jouées
          En haut,la main de l'adversaire
          En bas votre main
          Quatre cartes choisies au milieu
          3 cartes sont distribuées pour chaque joueur
Déroulement
          Chaque joueur, à tour de rôle,joue une carte.
          Jouer une carte revient à la placer sur la table au milieu.
          Quand une carte est jouée si la somme de sa valeur avec des cartes au milieu donnent 15 alors ces cartes sont gagnées par le joueur .
          Sison la carte est posée au milieu
Score
         Chaque carte égale 1 point
Objectif
Le joueur gagnant c'est le joueur le plus nombre de cartes."
                font.pixelSize: 12
            }

            Button {
                text: "▶ Commencer le jeu"
                onClicked: {
                    // Appeler la fonction C++ pour démarrer la distribution
                    // backend.startCardDistribution();
                    // Afficher la deuxième interface
                    cardDistribution.visible = true;
                    // Masquer la première interface
                    main.visible = false;
                }
            }
        }
    }

    Rectangle{

        id: cardDistribution
        width: window.width
        height: window.height
        visible: false
        color: "green"
        Column {
            anchors.fill: parent
            //width: window.width
            //height: window.height
            spacing:50



            // Afficher la main du joueur 1
            ListView {
                model: ListModel { }

                function initializeModel() {
                    // Initialize the model when called
                    var imageSources = [
                        { id: "image1", value: 1, source: "file:///C:/Users/hafsa/Documents/carta/images/01.gif" },
                        { id: "image2", value: 2, source: "file:///C:/Users/hafsa/Documents/carta/images/31.gif" },
                        { id: "image3", value: 3, source: "file:///C:/Users/hafsa/Documents/carta/images/03.gif" },
                        { id: "image4", value: 4, source:"file:///C:/Users/hafsa/Documents/carta/images/23.gif" },
                        { id: "image5", value: 5, source: "file:///C:/Users/hafsa/Documents/carta/images/04.gif" },
                        { id: "image6", value: 6, source: "file:///C:/Users/hafsa/Documents/carta/images/15.gif" },
                        { id: "image7", value: 7, source: "file:///C:/Users/hafsa/Documents/carta/images/36.gif" },
                        { id: "image10", value: 10, source:"file:///C:/Users/hafsa/Documents/carta/images/17.gif" },
                        { id: "image11", value: 11, source:"file:///C:/Users/hafsa/Documents/carta/images/18.gif" },
                        { id: "image12", value: 12, source:"file:///C:/Users/hafsa/Documents/carta/images/09.gif" }
                    ];

                        // Fill sourceListView with images
                        for (var i = 0; i < 3; ++i) {
                            var randomIndex = Math.floor(Math.random() * imageSources.length);
                            sourceListView.model.append(imageSources[randomIndex]);
                        }
                }

                Component.onCompleted: {
                    initializeModel();
                }

                Item {
                    width: parent.width
                    height: 10 // Adjust the height as needed
                    Text {
                        text: "Player A"
                        font.pixelSize: 20
                    }
                }

                    id: sourceListView
                    width: parent.width/3
                    spacing: 10
                    height: 200
                    orientation: ListView.Horizontal // Set the orientation to Horizontal

                    Button {
                        text: "Get cards"
                        anchors.right: parent.right
                        onClicked: {
                            if (sourceListView.model.count === 0) {
                                var imageSources = [
                                    { id: "image1", value: 1, source: "file:///C:/Users/hafsa/Documents/carta/images/01.gif" },
                                    { id: "image2", value: 2, source: "file:///C:/Users/hafsa/Documents/carta/images/31.gif" },
                                    { id: "image3", value: 3, source: "file:///C:/Users/hafsa/Documents/carta/images/03.gif" },
                                    { id: "image4", value: 4, source:"file:///C:/Users/hafsa/Documents/carta/images/23.gif" },
                                    { id: "image5", value: 5, source: "file:///C:/Users/hafsa/Documents/carta/images/04.gif" },
                                    { id: "image6", value: 6, source: "file:///C:/Users/hafsa/Documents/carta/images/15.gif" },
                                    { id: "image7", value: 7, source: "file:///C:/Users/hafsa/Documents/carta/images/36.gif" },
                                    { id: "image10", value: 10, source:"file:///C:/Users/hafsa/Documents/carta/images/17.gif" },
                                    { id: "image11", value: 11, source:"file:///C:/Users/hafsa/Documents/carta/images/18.gif" },
                                    { id: "image12", value: 12, source:"file:///C:/Users/hafsa/Documents/carta/images/09.gif" }
                                ];

                               // Add three random images to lastListView
                               for (var i = 0; i < 3; ++i) {
                                   var randomIndex = Math.floor(Math.random() * imageSources.length);
                                   sourceListView.model.append(imageSources[randomIndex]);
                               }
                             }
                        }
                    }


                    delegate: Item {
                        width: 100
                        height: parent.height
                        property int cardValue: model.value
                        MouseArea {
                                   anchors.fill: parent
                                   onClicked: {
                                       targetListView.model.append(model);
                                       var isWon=false;
                                       for (var i = 0; i < targetListView.model.count; ++i) {
                                           var otherValue = targetListView.model.get(i).value;
                                           if ((otherValue + cardValue) === 15 && !isWon) {
                                               targetListModel.remove(i);
                                               isWon =true;
                                            }
                                       }
                                       sourceListView.model.remove(index);
                                       if(isWon){

                                           targetListView.model.remove(targetListView.model.count - 1);
                                           customAlertText.text = "🎉🎉🎉Player A Won 🎉🎉🎉";
                                           customAlert.visible=true;

                                       }
                                   }

                                   Rectangle {
                                       width: 100
                                       height: parent.height
                                       color: "green"
                                       Image {
                                           anchors.centerIn: parent
                                           source: model.source
                                           fillMode: Image.PreserveAspectFit
                                       }
                                   }
                               }
                    }
                }

            ListView {
                id: targetListView
                width: parent.width / 1
                spacing: 10
                height: 150
                orientation: ListView.Horizontal
                cacheBuffer: targetListModel.count// Ensure all items are created

                model: ListModel {
                    id: targetListModel
                }
                function initializeModel() {
                    // Initialize the model when called
                    var imageSources = [
                        { id: "image1", value: 1, source: "file:///C:/Users/hafsa/Documents/carta/images/01.gif" },
                        { id: "image2", value: 2, source: "file:///C:/Users/hafsa/Documents/carta/images/31.gif" },
                        { id: "image3", value: 3, source: "file:///C:/Users/hafsa/Documents/carta/images/03.gif" },
                        { id: "image4", value: 4, source:"file:///C:/Users/hafsa/Documents/carta/images/23.gif" },
                        { id: "image5", value: 5, source: "file:///C:/Users/hafsa/Documents/carta/images/04.gif" },
                        { id: "image6", value: 6, source: "file:///C:/Users/hafsa/Documents/carta/images/15.gif" },
                        { id: "image7", value: 7, source: "file:///C:/Users/hafsa/Documents/carta/images/36.gif" },
                        { id: "image10", value: 10, source:"file:///C:/Users/hafsa/Documents/carta/images/17.gif" },
                        { id: "image11", value: 11, source:"file:///C:/Users/hafsa/Documents/carta/images/18.gif" },
                        { id: "image12", value: 12, source:"file:///C:/Users/hafsa/Documents/carta/images/09.gif" }
                    ];

                        // Fill sourceListView with images
                        for (var i = 0; i < 4; ++i) {
                            var randomIndex = Math.floor(Math.random() * imageSources.length);
                            targetListView.model.append(imageSources[randomIndex]);
                        }
                }

                Component.onCompleted: {
                    initializeModel();
                }


                delegate: Item {
                    width: 100
                    height: parent.height

                    Rectangle {
                              width: 100
                              height: parent.height
                              color: "lightgreen"

                              Image {
                                  anchors.fill: parent
                                  source: model.source
                                  fillMode: Image.PreserveAspectFit
                              }

                              MouseArea {
                                  anchors.fill: parent

                              }
                          }
                }
            }

            ListView {
                id:lastListView
                width: parent.width/3
                spacing: 10
                height: 150
                orientation: ListView.Horizontal // Set the orientation to Horizontal
                Item {
                    width: parent.width
                    height: 10 // Adjust the height as needed

                    Text {
                        text: "Player B"
                        font.pixelSize: 20
                    }
                }
                model: ListModel {
                }
                function initializeModel() {
                    // Initialize the model when called
                    var imageSources = [
                        { id: "image1", value: 1, source: "file:///C:/Users/hafsa/Documents/carta/images/01.gif" },
                        { id: "image2", value: 2, source: "file:///C:/Users/hafsa/Documents/carta/images/31.gif" },
                        { id: "image3", value: 3, source: "file:///C:/Users/hafsa/Documents/carta/images/03.gif" },
                        { id: "image4", value: 4, source:"file:///C:/Users/hafsa/Documents/carta/images/23.gif" },
                        { id: "image5", value: 5, source: "file:///C:/Users/hafsa/Documents/carta/images/04.gif" },
                        { id: "image6", value: 6, source: "file:///C:/Users/hafsa/Documents/carta/images/15.gif" },
                        { id: "image7", value: 7, source: "file:///C:/Users/hafsa/Documents/carta/images/36.gif" },
                        { id: "image10", value: 10, source:"file:///C:/Users/hafsa/Documents/carta/images/17.gif" },
                        { id: "image11", value: 11, source:"file:///C:/Users/hafsa/Documents/carta/images/18.gif" },
                        { id: "image12", value: 12, source:"file:///C:/Users/hafsa/Documents/carta/images/09.gif" }
                    ];

                        // Fill sourceListView with images
                        for (var i = 0; i < 3; ++i) {
                            var randomIndex = Math.floor(Math.random() * imageSources.length);
                            lastListView.model.append(imageSources[randomIndex]);
                        }
                }

                Component.onCompleted: {
                    initializeModel();
                }


                Button {
                    text: "Get cards"
                    anchors.right: parent.right
                    onClicked: {
                        if (lastListView.model.count === 0) {
                            var imageSources = [
                                { id: "image1", value: 1, source: "file:///C:/Users/hafsa/Documents/carta/images/01.gif" },
                                { id: "image2", value: 2, source: "file:///C:/Users/hafsa/Documents/carta/images/31.gif" },
                                { id: "image3", value: 3, source: "file:///C:/Users/hafsa/Documents/carta/images/03.gif" },
                                { id: "image4", value: 4, source:"file:///C:/Users/hafsa/Documents/carta/images/23.gif" },
                                { id: "image5", value: 5, source: "file:///C:/Users/hafsa/Documents/carta/images/04.gif" },
                                { id: "image6", value: 6, source: "file:///C:/Users/hafsa/Documents/carta/images/15.gif" },
                                { id: "image7", value: 7, source: "file:///C:/Users/hafsa/Documents/carta/images/36.gif" },
                                { id: "image10", value: 10, source:"file:///C:/Users/hafsa/Documents/carta/images/17.gif" },
                                { id: "image11", value: 11, source:"file:///C:/Users/hafsa/Documents/carta/images/18.gif" },
                                { id: "image12", value: 12, source:"file:///C:/Users/hafsa/Documents/carta/images/09.gif" }
                            ];

                            // Add three random images to lastListView
                           for (var i = 0; i < 3; ++i) {
                               var randomIndex = Math.floor(Math.random() * imageSources.length);
                               lastListView.model.append(imageSources[randomIndex]);
                           }
                         }
                    }
                }

                delegate: Item {
                    width: 100
                    height: parent.height
                    property int cardValue: model.value
                    MouseArea {
                       anchors.fill: parent
                       onClicked: {
                           targetListView.model.append(model);
                           var isWon=false;
                           for (var i = 0; i < targetListView.model.count; ++i) {
                               var otherValue = targetListView.model.get(i).value;
                               if ((otherValue + cardValue) === 15 && !isWon) {
                                   targetListModel.remove(i);
                                   isWon =true;
                                }
                           }
                           lastListView.model.remove(index);
                           if(isWon){

                               targetListView.model.remove(targetListView.model.count - 1);
                               customAlertText.text = "🎉🎉🎉Player B Won 🎉🎉🎉";
                               customAlert.visible=true;

                           }
                       }

                       Rectangle {
                           width: 100
                           height: 200
                           color: "green"
                           Image {
                               anchors.fill: parent
                               source: model.source
                               fillMode: Image.PreserveAspectFit
                           }
                        }
                       }
                   }
                }
            }
        Rectangle {
            id: customAlert
            width: 400
            height: 300
            color: "white"
            border.color: "white"
            radius: 20
            visible: false
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Text {
                id:customAlertText
                anchors.centerIn: parent
                text: ""
                font.pixelSize: 24
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    customAlert.visible = false;
                }
            }
        }
        }
    }


