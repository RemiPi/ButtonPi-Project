#!/bin/bash
#
Musique ()
{
	wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q='Musique'&tl=Fr-fr"
	mplayer output.mp3
	playlist=`echo $[($RANDOM % ($[max - 1] + 1)) + 1]`
	echo $playlist
	if [ $playlist = 1 ]
	then
	mplayer -playlist ~/ButtonPi/PiLaylist/Playlist1.m3u
	elif [ $playlist = 2 ]
	then
	mplayer -playlist ~/ButtonPi/PiLaylist/Playlist2.m3u
	elif [ $playlist = 3 ]
	then
	mplayer -playlist ~/ButtonPi/PiLaylist/Playlist3.m3u
	fi
	let "compte = compte + 1" && Principale
}

PiGenda ()
{
	wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q='PiGenda'&tl=Fr-fr"
	mplayer output.mp3
	date=`date +%A`
	lecture=`cat /home/pi/ButtonPi/PiGenda/"$date".txt`
	wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q='Tu as. $lecture'&tl=Fr-fr"
	mplayer output.mp3
	let "compte = compte + 1" && Principale
}

PiMeteo ()
{
	wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q='Récupération météo en cours'&tl=Fr-fr"
	mplayer output.mp3
	meteo=`curl http://www.prevision-meteo.ch/services/json/[ville]`
	ville=$(echo $meteo | jq '.city_info.name')
	condition=$(echo $meteo | jq '.current_condition.condition')
	tempactu=$(echo $meteo | jq '.current_condition.tmp')
	tempmin=$(echo $meteo | jq '.fcst_day_0.tmin')
	tempmax=$(echo $meteo | jq '.fcst_day_0.tmax')
	wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q='Météo pour aujourd'hui à $ville. $condition avec des température allant de $tempmin à $tempmax degrés. Actuellement, il fait dans les $tempactu degrés.'&tl=Fr-fr"
	mplayer output.mp3
	let "compte = compte + 1" && Principale
}


Principale ()
{
let "compte = 1"
gpio mode 4 in
gpio mode 0 out
gpio mode 2 out
gpio mode 3 out
gpio write 0 0 && gpio write 2 0 && gpio write 3 0
 echo -n "Waiting for button ..."

 while [ $compte = 1 ]; do
   if [ `gpio read 4` = 0 ]
	then
		gpio write 0 1
		sleep 1
		if [ `gpio read 4` = 0 ]
			then
				gpio write 2 1
				sleep 1
				if [ `gpio read 4` = 0 ]
					then
						gpio write 3 1
						let "compte = compte - 1"
						sleep 1
						PiMeteo
					else
						let "compte = compte - 1"
						sleep 1
						PiGenda
		                fi

			else
	        	        let "compte = compte - 1"
		                sleep 1
				Musique

		 fi
   fi
 done
}

jqpath=$(which jq)
if [ "$jqpath" = "" ]
then
        echo "ERREUR: jq non-installé"
        exit 69 # EX_UNAVAILABLE
else
        echo "jq : installé"
fi

gpiopath=$(which gpio)
if [ "$bcpath" = "" ]
then
        echo "ERREUR: wiringpi non-installé"
	exit 69 # EX_UNAVAILABLE
else
        echo "wiringpi : installé"
fi

mplayerpath=$(which mplayer)
if [ "$mplayerpath" = "" ]

then
        echo "ERREUR: mplayer non-installé"
        exit 69 # EX_UNAVAILABLE
else
        echo "mplayer : installé"
fi

Principale
