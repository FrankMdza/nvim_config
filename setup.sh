#!/bin/bash

VENV_PATH="$HOME/.virtualenvs/Pyenvmain"

# Crear el entorno virtual si no existe
if [ ! -d "$VENV_PATH" ]; then
  echo "🔧 Creating virtual environment: Pyenvmain..."
  python3 -m venv "$VENV_PATH"
fi

# Activar entorno virtual
source "$VENV_PATH/bin/activate"

# Instalar dependencias desde requirements.txt si existe
REQUIREMENTS_FILE="requirements.txt"
if [ -f "$REQUIREMENTS_FILE" ]; then
  echo "📦 Installing dependencies from $REQUIREMENTS_FILE..."
  pip install --upgrade -r "$REQUIREMENTS_FILE"
else
  echo "⚠️ No requirements.txt found. Installing only pynvim..."
  pip install --upgrade pynvim
fi

echo "✅ Neovim Python provider is set up!"
