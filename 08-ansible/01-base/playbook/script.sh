#!/bin/bash

CONTAINERS=("ubuntu" "centos7" "fedora")

start_containers() {
  echo "Запуск контейнеров ..."
  
  for container in "${CONTAINERS[@]}"; do
    docker start "$container"
    if [ $? -ne 0 ]; then
      echo "Ошибка запуска контейнера $container"
      exit 1
    fi
    echo "Контейнер $container запущен."
  done
}

run_playbook() {
  echo "Запуск playbook ..."
  
  ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
  if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении playbook"
    stop_containers
    exit 1
  fi

  echo "Playbook выполнен."
}

stop_containers() {
  echo "Остановка контейнеров ..."
  
  for container in "${CONTAINERS[@]}"; do
    docker stop $container
    if [ $? -ne 0 ]; then
      echo "Ошибка при остановке $container"
      exit 1
    fi
    echo "Контейнер $container остановлен."
  done
}

start_containers
run_playbook
stop_containers

echo "Скрипт завершен."
