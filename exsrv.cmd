:: Utility Batch File To Start/Stop Elixir App As Windows Service
:: Onorio Catenacci
:: 19 November 2015

@echo off
SET COMMAND=%2
SET ERTS_BIN_PATH=C:/progra~1/erl7.1/erts-7.1/bin
SET ERLSRV_CMD=%ERTS_BIN_PATH%/erlsrv
SET APPNAME=%1

IF /I %COMMAND%==INSTALL (CALL :INSTALL)
IF /I %COMMAND%==START (CALL :START)
IF /I %COMMAND%==STOP (CALL :STOP)
IF /I %COMMAND%==REMOVE (CALL :REMOVE)
GOTO :EOF

:INSTALL
CALL :REMOVE
ECHO Installing %APPNAME% service
%ERLSRV_CMD% add %APPNAME% -machine %ERTS_BIN_PATH%/start_erl.exe -c "%APPNAME% Elixir Service" -w %TEMP% -n %APPNAME%@localhost -d reuse
GOTO :EOF

:REMOVE
CALL :STOP
ECHO Removing %APPNAME% service
%ERLSRV_CMD% remove %APPNAME%
GOTO :EOF

:START
%ERLSRV_CMD% start %APPNAME%
GOTO :EOF

:STOP
ECHO Stopping %APPNAME% service
%ERLSRV_CMD% stop %APPNAME%
GOTO :EOF

