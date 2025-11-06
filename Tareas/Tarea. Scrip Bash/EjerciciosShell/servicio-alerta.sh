#!/bin/bash
# Servicio para el demonio 'alerta': start|stop|restart|status

DAEMON=./alerta
PIDFILE=/tmp/alerta.pid
DEFAULT_SECONDS=2

function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 start [SEGUNDOS] | stop | restart [SEGUNDOS] | status

DESCRIPCIÓN
  Arranca, para, relanza y muestra el estado del demonio 'alerta'.

CÓDIGOS DE RETORNO
  0  Sin errores.
  1  Parámetro inválido.
  2  Error al iniciar (binario no encontrado o no ejecutable).
DESCRIPCION_AYUDA
}

function is_running() {
  if [ -f "$PIDFILE" ]; then
    local pid
    pid=$(cat "$PIDFILE")
    if [ -n "$pid" ] && ps -p "$pid" > /dev/null 2>&1; then
      return 0
    else
      # PID obsoleto: limpiar
      rm -f "$PIDFILE"
    fi
  fi
  return 1
}

function do_start() {
  local seconds="$1"
  [[ "$seconds" =~ ^[0-9]+$ ]] || seconds="$DEFAULT_SECONDS"

  if is_running; then
    echo "El proceso ya se está ejecutando."
    return 0
  fi

  if [ ! -x "$DAEMON" ]; then
    echo "No se encontró el demonio ejecutable: $DAEMON"
    exit 2
  fi

  "$DAEMON" "$seconds" &
  echo $! > "$PIDFILE"
  echo "Ejecutándose... (PID $(cat "$PIDFILE"), intervalo ${seconds}s)"
}

function do_stop() {
  if ! is_running; then
    echo "Parado."
    return 0
  fi

  local pid
  pid=$(cat "$PIDFILE")

  kill "$pid" 2>/dev/null
  sleep 0.2

  if ps -p "$pid" > /dev/null 2>&1; then
    kill -9 "$pid" 2>/dev/null
  fi

  rm -f "$PIDFILE"
  echo "Parado."
}

function do_restart() {
  local seconds="$1"
  do_stop
  do_start "$seconds"
}

function do_status() {
  if is_running; then
    echo "Ejecutándose... (PID $(cat "$PIDFILE"))"
  else
    echo "Parado."
  fi
}

case "$1" in
  -h|--help|"")
    ayuda
    ;;
  start)
    do_start "$2"
    ;;
  stop)
    do_stop
    ;;
  restart)
    do_restart "$2"
    ;;
  status)
    do_status
    ;;
  *)
    echo "Parámetro '$1' incorrecto."
    exit 1
    ;;
esac
