# Домашнє завдання: №34. Jenkins.

## Деплой Jenkins в контейнері

- [docker-compose.yml](Jenkins/docker-compose.yml)

## Налаштування Jenkins через веб-інтерфейс

- /opt/Docker/Jenkins/jenkins_home/secrets/initialAdminPassword – тут дивимось пароль для першого входу
- Після вхожу за адресою http://test:8080/ та налаштування адмін користувача, встановлюємо плагіни:

```Bash
- Pipeline (вже був встановлений)
- Git (вже був встановлений)
- Notify.Events (для нотифікації в Telegram)
- Publish Over SSH
```

## Налаштування EC2

- Розгортаємо інстанс
- Додаємо credentials: Jenkins → Manage Jenkins → Security → Credentials → Add credentials
- Налаштування SSH сервера: Jenkins → Manage Jenkins → System → Publish over SSH секція → SSH Servers → Add
- Створення тестового job: New Item → Freestyle project → Test-Connection → Build Steps → Send files or execute commands over SSH:
  - SSH Server: test-pet
  - Exec command:

  ```Bash
  whoami
  java -version
  ls -la /opt/spring-app/
  ```

![output001](screens/output001.jpg)

## Налаштування Freestyle Job

### Maven installations:

- Додаємо credentials: Jenkins → Tools → Maven installations → Add Maven

### Створення Freestyle Job:

------- тут домашка обривається, т.я. не встиг до дедлайну -------