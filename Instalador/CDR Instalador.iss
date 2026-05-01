[Setup]
AppName=Calculadora de Rentabilidade
AppVersion=1.0
DefaultDirName={pf}\CalculadoraRentabilidade
DefaultGroupName=Calculadora Rentabilidade
OutputDir=output
OutputBaseFilename=CalculadoraRentabilidadeSetup
Compression=lzma
SolidCompression=yes

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
[Icons]
Name: "{group}\Calculadora Rentabilidade"; Filename: "{app}\calculadora_rentabilidade.exe"
Name: "{commondesktop}\Calculadora Rentabilidade"; Filename: "{app}\calculadora_rentabilidade.exe"

[Run]
Filename: "{app}\calculadora_rentabilidade.exe"; Description: "Abrir aplicativo"; Flags: nowait postinstall skipifsilent