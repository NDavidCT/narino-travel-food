# Script para deshabilitar sonidos en VS Code
Write-Host "🔇 Deshabilitando sonidos de VS Code..." -ForegroundColor Cyan

# Configuraciones para deshabilitar audio
$audioSettings = @{
    "accessibility.signals.enabled" = $false
    "accessibility.signals.sounds" = $false
    "accessibility.signals.lineHasBreakpoint" = "off"
    "accessibility.signals.lineHasError" = "off"
    "accessibility.signals.lineHasFoldedArea" = "off"
    "accessibility.signals.lineHasInlineSuggestion" = "off"
    "accessibility.signals.lineHasWarning" = "off"
    "accessibility.signals.onDebugBreak" = "off"
    "accessibility.signals.noInlayHints" = "off"
    "accessibility.signals.taskCompleted" = "off"
    "accessibility.signals.taskFailed" = "off"
    "accessibility.signals.terminalCommandFailed" = "off"
    "accessibility.signals.terminalQuickFix" = "off"
    "workbench.accessibility.keyboardNavigation" = $false
    "editor.accessibilitySupport" = "off"
    "audioCues.enabled" = $false
    "audioCues.volume" = 0
    "accessibility.voice.keywordActivation" = "off"
}

Write-Host "✅ Configuraciones preparadas" -ForegroundColor Green
Write-Host ""
Write-Host "🔧 INSTRUCCIONES PARA APLICAR:" -ForegroundColor Yellow
Write-Host "1. Presiona Ctrl+, en VS Code" -ForegroundColor White
Write-Host "2. En el buscador escribe: 'accessibility.signals'" -ForegroundColor White
Write-Host "3. Desactiva TODAS las opciones de señales de accesibilidad" -ForegroundColor White
Write-Host "4. Busca 'audioCues' y desactiva todo" -ForegroundColor White
Write-Host "5. Busca 'accessibility.voice' y ponlo en 'off'" -ForegroundColor White
Write-Host ""
Write-Host "🎯 O más fácil: Presiona Ctrl+Shift+P y escribe 'settings json'" -ForegroundColor Cyan
Write-Host "   Luego copia las configuraciones del archivo vscode_audio_fix.json" -ForegroundColor Cyan