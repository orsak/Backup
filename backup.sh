#!/bin/bash
clear
date
salida=1
read -p "¿desea guardar la copia en otro equipo?:  [s/n] " y
if [[ "$y" = "s" ]]; then
	read -p "introduzca un usuario: " usuario
	read -p "introduzca la ip donde desea almacenar la copia: " ip
	read -p "introduzca la ruta remota donde desea guardar la copia: " ruta	#statements
else
	echo -e "\t ¡¡ IMPORTANTE NO SE VAN A REALIZAR COPIAS REMOTAS !!"
fi

while [[ $salida = 1 ]]; do
echo -e "\t/////////////////////////////"
echo -e "\t/Menú de copias de Seguridad/"
echo -e "\t/////////////////////////////"
echo ""
echo "Bienvenido al Programa para la realizacion de copias de Seguridad"
echo "Introduzca una opcion:"
echo "1.- Realización de Copia de Seguridad Completas"
echo "2.- Realización de Copia de Seguridad Parcial"
echo "3.- Realizacion de Copia de Seguridad Diferencial"
echo "6.- Salir del Programa"
echo ""

read -p "introduzca una opcion: " opcion

case $opcion in
	1) echo "Ha escogido la opcion de Copias de Seguridad Completas"	
		read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
		if [[ $copia="" ]]; then
			while [[ $copia = "" ]]; do
				read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
				if [[ $copia="" ]]; then
					echo "la ruta esta vacia"
				fi
			done
		fi
		read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
			if [[ $backup = "" ]]; then
			 	while [[ $backup = "" ]]; do
					read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
					if [[ $backup = "" ]]; then
						echo "la ruta esta vacia"
					fi	
				done
			fi
		read -p "Porporcione un nombre a la copia de seguridad: " nombre
			if [[ $nombre = "" ]]; then
			 	while [[ $nombre = "" ]]; do
					read -p "Porporcione un nombre a la copia de seguridad " nombre
					if [[ $nombre = "" ]]; then
					echo "No ha introducido ningun nombre"
				fi
				done
			fi
		echo ""
		echo "la ruta a guradar será: " $copia
		echo "la ruta donde guardar la copia será: " $backup
		echo "el nombre de la copia será: "$nombre
		sleep 3
		actual=`pwd`
		cd $backup
		rm full*
		rm *.snap
		cd $actual
		tar -cpvzf "full_"$nombre"_`date +%d%m%Y`.tgz" -g $backup/backup.snap $copia/*
		mv "full_"$nombre"_`date +%d%m%Y`.tgz" $backup
		
		echo -e "\t*********************************"
		echo -e "\t*Copia Total Realizada con exito*"
		echo -e "\t*********************************"
		echo ""
		
		if [[ ! "$ip" = "" && ! "$ruta" = "" && ! "$usuario" = "" ]]; then
			cd $backup
			scp *.snap $usuario@$ip:$ruta
			scp full_"$nombre"_`date +%d%m%Y`.tgz $usuario@$ip:$ruta
			echo -e "\t###############################"
			echo -e "\t#Archivo enviado correctamente#"
			echo -e "\t###############################"
			echo ""
			sleep 2
		else
			echo -e "\t#####################################"
			echo -e "\t¡¡¡No va a realizar copias remotas!!!"
			echo -e "\t#####################################"
			echo ""
			sleep 2
		fi
		;;
	2) echo "Ha escogido la opcion de Copias de Seguridad Parcial"
		read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
		if [[ $copia="" ]]; then
			while [[ $copia = "" ]]; do
				read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
				if [[ $copia="" ]]; then
					echo "la ruta esta vacia"
				fi
			done
		fi
		read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
			if [[ $backup = "" ]]; then
			 	while [[ $backup = "" ]]; do
					read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
					if [[ $backup = "" ]]; then
						echo "la ruta esta vacia"
					fi	
				done
			fi
		read -p "Porporcione un nombre a la copia de seguridad " nombre
			if [[ $nombre = "" ]]; then
			 	while [[ $nombre = "" ]]; do
					read -p "Porporcione un nombre a la copia de seguridad " nombre
					if [[ $nombre = "" ]]; then
					echo "No ha introducido ningun nombre"
				fi
				done
			fi
		echo "la ruta a guradar será: " $copia
		echo "la ruta donde guardar la copia será: " $backup
		echo "el nombre de la copia será: "$nombre
		sleep 3
		tar -cpvzf "inc_"$nombre"_`date +%d%m%Y`.tgz" -g $backup/backup.snap $copia/*
		mv "inc_"$nombre"_`date +%d%m%Y`.tgz" $backup
		
		echo -e "\t************************************"
		echo -e "\t*Copia Parcial Realizada con exito*"
		echo -e "\t***********************************"
		echo ""
		
		if [[ ! "$ip" = "" && ! "$ruta" = "" && ! "$usuario" = "" ]]; then
			cd $backup
			scp "inc_"$nombre"_`date +%d%m%Y`.tgz" $usuario@$ip:$ruta
			echo -e "\t###############################"
			echo -e "\t#Archivo enviado correctamente#"
			echo -e "\t###############################"
			echo ""
			sleep 2
		else
			echo -e "\t#####################################"
			echo -e "\t¡¡¡No va a realizar copias remotas!!!"
			echo -e "\t#####################################"
			echo ""
			sleep 2
		fi
		;;

	3) echo "Ha escogido la opcion de Copias de Seguridad Diferencial"
			read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
		if [[ $copia="" ]]; then
			while [[ $copia = "" ]]; do
				read -p "Porporcione la ruta de la que desea hacer la copia de seguridad " copia
				if [[ $copia="" ]]; then
					echo "la ruta esta vacia"
				fi
			done
		fi
		read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
			if [[ $backup = "" ]]; then
			 	while [[ $backup = "" ]]; do
					read -p "Porporcione la ruta donde desea guardar la copia de seguridad " backup
					if [[ $backup = "" ]]; then
						echo "la ruta esta vacia"
					fi	
				done
			fi
		read -p "Porporcione un nombre a la copia de seguridad " nombre
			if [[ $nombre = "" ]]; then
			 	while [[ $nombre = "" ]]; do
					read -p "Porporcione un nombre a la copia de seguridad " nombre
					if [[ $nombre = "" ]]; then
					echo "No ha introducido ningun nombre"
				fi
				done
			fi
		echo "la ruta a guradar será: " $copia
		echo "la ruta donde guardar la copia será: " $backup
		echo "el nombre de la copia será: "$nombre
		cd "$backup"
		fecha=`find full* | cut -d "_" -f 3| cut -d "." -f1`
		sleep 3
		tar -cpvzf "dif1_"$nombre"_`date +%d%m%Y`.tar.gz" $copia/* -N $fecha
		mv "dif1_"$nombre"_`date +%d%m%Y`.tar.gz" $backup
		
		echo -e "\t***************************************"
		echo -e "\t*Copia Diferencial Realizada con exito*"
		echo -e "\t***************************************"
		echo ""
		
		if [[ ! "$ip" = "" && ! "$ruta" = "" && ! "$usuario" = "" ]]; then
			cd $backup
			scp "dif1_"$nombre"_`date +%d%m%Y`.tar.gz" $usuario@$ip:$ruta
			echo -e "\t###############################"
			echo -e "\t#Archivo enviado correctamente#"
			echo -e "\t###############################"
			echo ""
			sleep 2
		else
			echo -e "\t#####################################"
			echo -e "\t¡¡¡No va a realizar copias remotas!!!"
			echo -e "\t#####################################"
			echo ""
			sleep 2
		fi
		;;

	6) echo "Salir"
		#para poder salir del menú
		read -p "¿Desea realmente salir? [y/n]" x 
		if [[ "$x" = "y" ]]; then
			salida=0;
		else
			clear
			salida=1;
		fi
		;;

	*) echo "digame una opción"

esac
done