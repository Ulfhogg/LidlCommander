@ECHO off
SET interactive=0
COLOR 1E

:: LidlCommander tool for Spanish Team 
:: Wincor-Nixdorf Poland 2016
:: Creative Commons - Jaime Villar Camacho
:: No kasierkas were harmed during execution of this script.
:: Beta 0.0.1 

:: menu
:start
cls
ECHO ++==[ Bienvenido a LidlCommander ]==++
ECHO ++ Por favor seleccione una opcion +++
ECHO.
ECHO  1) Reinciar caja
ECHO  2) Reinciar aplicacion de caja
ECHO  3) Buscar y borrar Nullgk_bon
ECHO  4) Reinciar aplicacion de BO [NOT WORKING]
ECHO  5) Ping
ECHO  6) Reinciar servicio CA SupportBridge
ECHO  7) Reinstalar servicio C3
::ECHO  8) Borrar archivelog expirados (STABLENET)
ECHO  0) Salir
ECHO.
ECHO ++==================================++
ECHO ++==================================++
ECHO.

:: options
SET /P var=Escriba el numero de la opcion [1-7] o salir:
IF "%var%"=="1"  GOTO op1
IF "%var%"=="2"  GOTO op2
IF "%var%"=="3"  GOTO op3
IF "%var%"=="4"  GOTO op4
IF "%var%"=="5"  GOTO op5
IF "%var%"=="6"  GOTO op6
IF "%var%"=="7"  GOTO op7
::IF "%var%"=="8"  GOTO op8
IF "%var%"=="0"  GOTO salir
ECHO.

:: exception when out of option range0963
ECHO El valor " %var% " no es una opcion valida, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO start

:: // functions section //

:: function 1 reboot till
:op1
ECHO.
ECHO +++= (1) Reiniciar caja =+++
SET /P store=Escriba el numero de tienda con 4 digitos:
ECHO.
SET /P till=Escriba el numero de caja con 2 digitos:

psshutdown \\es-"%store%"TI"%till%" -r -t 1

ECHO Caja reiniciadose.
ECHO.
PAUSE
GOTO start

:: exception handling when out of option range
ECHO.
ECHO El numero de tienda o caja no es correcto, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO op1


:: function 2 reboot POS application
:op2
ECHO.
ECHO +++= (2) Reiniciar aplicacion de caja =+++
SET /P store=Escriba el numero de tienda con 4 digitos:
ECHO.
SET /P till=Escriba el numero de caja con 2 digitos:
ECHO.

pskill \\es-"%store%"TI"%till%" cmd.exe -u wepos -p LIdL123! -t
ECHO Aplicacion de caja parada.
ECHO.
PAUSE

psexec \\es-"%store%"TI"%till%"  -i -d   c:\gkretail\pos\jstore_ES.cmd -u wepos -p LIdL123! 
ECHO Aplicacion de caja reinciada.
ECHO.
PAUSE
GOTO start

:: exception handling when out of option range
ECHO.
ECHO El numero de tienda o caja no es correcto, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO op2


:: function 3 nullgk_bon
:op3
ECHO.
ECHO +++= (3) Buscar y eliminar Nullgk_bon =+++
ECHO.
SET /P store=Escriba el numero de tienda con 4 digitos:
ECHO.
SET /P till=Escriba el numero de caja con 2 digitos:

IF EXIST \\es-"%store%"ti"%till%"\c$\gkretail\pos\nullgk_bon (
:: check if nullgk_bon exist, then jump to nullgk_bon label else goto start
ECHO.
ECHO Habemus nullgk_bon !!!.
GOTO nullgk_bon 
PAUSE
) ELSE (
ECHO No hay nullgk_bon
PAUSE
GOTO start
)

:: exception handling when out of option range
ECHO.
ECHO El numero de tienda o caja no es correcto, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO op3

	:: function nullgk_bon, press 1 then go to another label to delete file and restart till application
	:nullgk_bon
	ECHO.
	SET /P siono=Pulse 1 para eliminar o cualquier otra tecla para pasar palabra.
	IF "%siono%"=="1" GOTO del (
	) ELSE (
	GOTO start
	)

	:: function del > delete file, restart till app and go back to start
	:del
	DEL \\es-"%store%"ti"%till%"\c$\gkretail\pos\nullgk_bon
	ECHO Fichero borrado.
	ECHO.
	PAUSE
	
	pskill \\es-"%store%"TI"%till%" cmd.exe -u wepos -p LIdL123! -t
	ECHO Aplicacion de caja parada.
	ECHO.
	PAUSE
	
	psexec \\es-"%store%"TI"%till%"  -i -d   c:\gkretail\pos\jstore_ES.cmd -u wepos -p LIdL123!
	ECHO.
	ECHO Archivo nullgk_bon BORRADO y aplicacion de caja reiniciada!!
	ECHO Volvemos a menu principal.
	ECHO.
	
	PAUSE
	GOTO start


:: function 4 reboot BO application
:op4
ECHO.
ECHO +++= (4) Reiniciar aplicacion de BO =+++
ECHO.
ECHO ESTA OPCION AUN NO ESTA HABILITADA, WORK IN PROGRESS
::SET /P store=Escriba el numero de tienda con 4 digitos:
REM ??

PAUSE
ECHO.
GOTO start


:: function 5 pinging (sub-options)
:op5
ECHO.
ECHO +++= (5) Ping =+++
ECHO.
ECHO Por favor seleccine una opcion
ECHO.
ECHO 1) Router de Telefonica
ECHO 2) Virtual Private Network
ECHO 3) Access Point
ECHO 4) Caja
ECHO 5) Back Office
ECHO 6) Impresora
ECHO.

	:: options
	SET /P var=Escriba el numero de la opcion [1-5]:
	IF "%var%"=="1"  GOTO telefonica
	IF "%var%"=="2"  GOTO vpn
	IF "%var%"=="3"  GOTO ap
	IF "%var%"=="4"  GOTO caja
	IF "%var%"=="5"  GOTO bo
	IF "%var%"=="6"	 GOTO impresora
	ECHO.

	:: exception when out of option range
	ECHO.
    ECHO El numero de tienda o caja no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO op5
	
	:telefonica
	ECHO.
	ECHO += (5.1) Ping Router de Telefonica =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-%store%nr01 -n "%n%"

	PAUSE
	GOTO start
	
	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO telefonica	

	:vpn
	ECHO.
	ECHO += (5.2) Ping VPN =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-"%store%"vpn01 -n "%n%"
	
	PAUSE
	GOTO start

	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO vpn

	:ap
	ECHO.
	ECHO += (5.3) Ping APs =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P ap=Escriba el numero de punto de acceso con 2 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-"%store%"wn"%ap%" -n "%n%"
	
	PAUSE
	GOTO start
	
	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO ap

	:caja
	ECHO.
	ECHO += (5.4) Ping Caja =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P till=Escriba el numero de la caja con 2 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-"%store%"TI"%till%" -n "%n%"
	
	PAUSE
	GOTO start
	
	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda o caja no es correcto, intentelo de nuevo..
	ECHO.
	PAUSE
	ECHO.
	GOTO caja	

	:bo
	ECHO.
	ECHO += (5.5) Ping Back Office =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-"%store%"bo01 -t
	
	PAUSE
	GOTO start
		
	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO bo

	PAUSE
	ECHO.
	GOTO start
	
	:impresora
	ECHO.
	ECHO += (5.6) Ping Impresora =+
	ECHO.
	SET /P store=Escriba el numero de tienda con 4 digitos:
	ECHO.
	SET /P n=Escriba el numero de repeticiones del ping:
	ECHO.
	
	ping es-%store%np01 -n "%n%"
	
	PAUSE
	GOTO start

	:: exception when out of option range
	ECHO.
	ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
	ECHO.
	PAUSE
	ECHO.
	GOTO impresora		

	
:: function 6 restart stuck blue user on SupportBridge
:op6
ECHO.
ECHO +++= (6) Reiniciar servicio CA SupportBridge =+++
ECHO.
SET /P store=Escriba el numero de la tienda con 4 digitos:
ECHO.

psservice \\es-"%store%"bo01 restart t-connect

PAUSE
GOTO start

:: exception when out of option range
ECHO.
ECHO El numero de tienda %store% no es correcto, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO op6


:: function 7 C3
:op7
ECHO.
ECHO +++= (7) Reinstalar servicio C3 =+++
ECHO.
SET /P store=Escriba el numero de la tienda con 4 digitos:
ECHO.
SET /P till=Escriba el numero de la caja con 2 digitos:
ECHO.

psexec \\es-"%store%"TI"%till%" -d C:\gkretail\pos\native\c3_es_net\service_install\c3_service_install.bat

PAUSE
GOTO start

:: exception when out of option range
ECHO.
ECHO El numero de tienda o caja no es correcto, intentelo de nuevo.
ECHO.
PAUSE
ECHO.
GOTO op7


:: function 8 delete expired archivelog STABLENET drive E
::op8
::ECHO.
::ECHO +++= (8) Borrar archivelog expirados (STABLENET) =+++
::ECHO.
::ECHO 
::rman target /

::crosscheck archivelog all;

::delete expired archivelog all;
::PAUSE
::ECHO DONE
::PAUSE

::GOTO start

:: exit 
@cls&exit

:: EoF
ENDLOCAL
ECHO ON
@EXIT /B 0
