#!/usr/bin/env bash
# Archivo de salida
output_file="nvim_config_dump.txt"
# Asegurar que el archivo de salida esté vacío al inicio
>"$output_file"
# Configurar opciones de glob
shopt -s dotglob nullglob globstar
# Lista de carpetas y archivos a ignorar
ignore_list=(
  ".git"
  ".DS_Store"
  "lazy-lock.json"
  "*.swap"
  "*.un~"
  "*.spl"
  "*.add.spl"
  "*.old"
  "*.bak"
)
# Función para verificar si un archivo debe ser ignorado
should_ignore() {
  local path="$1"
  for ignore in "${ignore_list[@]}"; do
    if [[ "$path" == *"$ignore"* ]]; then
      return 0
    fi
  done
  return 1
}
# Función para obtener la ruta de configuración de Neovim en NixOS
get_nvim_config_path() {
  # En NixOS, la configuración suele estar en ~/.config/nvim
  # Pero también podría estar gestionada por home-manager
  if [ -d "$HOME/.config/nvim" ]; then
    echo "$HOME/.config/nvim"
  elif [ -d "$HOME/nixos-config/home-manager/neovim" ]; then
    echo "$HOME/nixos-config/home-manager/neovim"
  else
    echo "Error: No se encontró el directorio de configuración de Neovim"
    exit 1
  fi
}
# Obtener la ruta de configuración
NVIM_CONFIG_PATH=$(get_nvim_config_path)
# Verificar si el directorio existe
if [ ! -d "$NVIM_CONFIG_PATH" ]; then
  echo "Error: No se encontró el directorio de configuración de Neovim en $NVIM_CONFIG_PATH"
  exit 1
fi
# Escribir encabezado
echo "=== Configuración de Neovim en NixOS ===" >"$output_file"
echo "Fecha: $(date)" >>"$output_file"
echo "Ruta: $NVIM_CONFIG_PATH" >>"$output_file"
echo "===============================" >>"$output_file"
echo >>"$output_file"
# Encontrar y procesar todos los archivos .lua, excluyendo directorios de Nix
find "$NVIM_CONFIG_PATH" -type f -name "*.lua" \
  -not -path "*/store/*" \
  -not -path "*/nix/*" | while read -r file; do
  # Obtener ruta relativa
  relative_path="${file#$NVIM_CONFIG_PATH/}"
  # Verificar si el archivo debe ser ignorado
  if should_ignore "$relative_path"; then
    continue
  fi
  # Agregar separador y nombre del archivo
  echo "==> Archivo: $relative_path <==" >>"$output_file"
  echo >>"$output_file"
  # Agregar contenido del archivo
  cat "$file" >>"$output_file"
  # Agregar separador final
  echo >>"$output_file"
  echo "==> Fin de $relative_path <==" >>"$output_file"
  echo >>"$output_file"
  echo "----------------------------------------" >>"$output_file"
  echo >>"$output_file"
done
echo "Script completado. La configuración ha sido guardada en $output_file"
# Mostrar estadísticas
echo "Estadísticas:"
echo "Número de archivos procesados: $(find "$NVIM_CONFIG_PATH" -type f -name "*.lua" -not -path "*/store/*" -not -path "*/nix/*" | wc -l)"
echo "Tamaño del archivo de salida: $(du -h "$output_file" | cut -f1)"
