##################################################################################################
##                                                                                              ##
##  //////////    //          //    ////////////    ////////////    ////////      ////      //  ##
##  //        //  //          //         //              //       //        //    // //     //  ##
##  //        //  //          //         //              //       //        //    //  //    //  ##
##  //////////    //          //         //              //       //        //    //   //   //  ##
##  //        //  //          //         //              //       //        //    //    //  //  ##
##  //        //  //          //         //              //       //        //    //     // //  ##
##  //////////      //////////           //              //         ////////      //      ////  ##
##                                                                                              ##
##                                                                                              ##
##                               //////////     //////////                                      ##
##                              //        //        //                                          ##
##                              //        //        //                                          ##
##                              //        //        //                                          ##
##                              //////////          //                                          ##
##                              //                  //                                          ##
##                              //              //////////                                      ##
##                                                                                              ##
##################################################################################################

Une fois le fichier copié à partir de github : git http://......

Ne pas oublier de télécharger : bc, jq, mplayer, wiringpi (tuto : https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/)

Les led doivent être branché au pins : 17, 27, 22
Le bouton doit être branché sur le pin : 23

Voici ce qu'il faut modifier dans le fichier ButtonPi.sh :


Dans musique() :- changer le "max" en fonction du nombre de playlist que vous avez,
		- rajouter des blocs "elif [$playlist = ..] ... fi" si vous avez plus de 3 playlist (ne pas oublier de changer les chiffre en conséquence)

Dans PiMeteo () :- changer le mot "[ville]" par la ville dans laquelle vous habitez. Pour savoir comment est nommé votre ville
dans l'url, rendez-vous sur : http://www.prevision-meteo.ch/ et recherchez votre ville, ensuite regarder l'url du site et regardez
comment est inscrit votre ville dans l'url (exemple : http://www.prevision-meteo.ch/meteo/localite/paris, http://www.prevision-meteo.ch/meteo/localite/saint-omer-62, etc...)
Une vois que c'est fait, copiez votre ville (comme elle est inscrit dans l'url), puis collez-la à la place de [ville] dans le fichier.

INFOS IMPORTANTES :
-Pour ajouter des rdv/choses à faire dans le PiGenda, rendez-vous dans le dossier PiGenda, puis écrivez les choses à faire dans le fichier du jour concerné.
-Les Musiques et playlists (sous le format "Playlist1.m3u", "Playlist2.m3u", etc... Doivent toutes être dans le fichier PiLaylist.
		