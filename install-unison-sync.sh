#!/bin/bash

# ============================================
# Instalador interactivo para Unison Sync
# Requiere ejecución como root
# ============================================

if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi

echo "=== Instalador de sincronización con Unison ==="
echo ""

# --- Pedir rutas al usuario ---
read -p "Ruta 1 (ej: /home/kali/machines): " RUTA1
read -p "Ruta 2 (ej: /mnt/hgfs/shared/machines): " RUTA2

# Crear carpeta de perfiles si no existe
mkdir -p /root/.unison

# Crear perfil
echo "Creando perfil de Unison..."

cat > /root/.unison/machines.prf <<EOF
root = $RUTA1
root = $RUTA2

auto = true
batch = true
prefer = newer

# Ignorar entornos virtuales
ignore = Name venv
ignore = Name .venv

# Ignorar carpetas de Python
ignore = Name __pycache__

# Ignorar repositorios
ignore = Name .git

# Permisos especiales para carpetas montadas
perms = 0
dontchmod = true
ignoreinodenumbers = true
times = false
EOF

echo "Perfil creado en /root/.unison/machines.prf"
echo ""

# --- Crear script ejecutable ---
echo "Creando script ejecutable..."

cat > /usr/local/bin/unison-machines.sh <<EOF
#!/bin/bash
/usr/bin/unison machines
EOF

chmod +x /usr/local/bin/unison-machines.sh

echo "Script creado en /usr/local/bin/unison-machines.sh"
echo ""

# --- Crear servicio systemd ---
echo "Creando servicio systemd..."

cat > /etc/systemd/system/unison-machines.service <<EOF
[Unit]
Description=Unison sync for machines folders

[Service]
Type=oneshot
User=root
ExecStart=/usr/local/bin/unison-machines.sh
EOF

echo "Servicio creado en /etc/systemd/system/unison-machines.service"
echo ""

# --- Crear timer ---
echo "Creando timer systemd..."

cat > /etc/systemd/system/unison-machines.timer <<EOF
[Unit]
Description=Run Unison machines sync periodically

[Timer]
OnBootSec=30
OnUnitActiveSec=30

[Install]
WantedBy=timers.target
EOF

echo "Timer creado en /etc/systemd/system/unison-machines.timer"
echo ""

# --- Activar todo ---
echo "Activando servicio y timer..."

systemctl daemon-reload
systemctl enable --now unison-machines.timer

echo ""
echo "=== Instalación completada ==="
echo "Unison sincronizará cada 30 segundos."
echo "Puedes ver el estado con:"
echo "  systemctl status unison-machines.timer"
echo "  journalctl -u unison-machines.service -f"