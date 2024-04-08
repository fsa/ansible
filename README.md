# Введение

Это мой набор плейбуков для Ansible, который решает мои задачи по настройке виртуальных машин. Буду рад, если он поможет вам в вашей работе. Все плейбуки вы можете выполнять только на свой страх и риск. Читайте внимательно текст плейбуков перед их запуском и всегда имейте варианты отката от изменений, которые могут нарушить работу вашего сервера.

## install.yaml

Первоначальная настройка сервера. После завершения работы скрипта доступ к серверу будет возможет только по ключу. Доступ пользователю root будет закрыт!!!

Для работы скрипта требуются установленные переменные. Можно их устанавливать для каждого сервера отдельно, но если они одинаковые, то для удобства их можно установить в `group_vars` для группы `install`:

```yaml
admin_user_name: ADMIN_USERNAME
admin_user_password: ADMIN_PASSWORD
```

ADMIN_USERNAME - пользователь, используемый для управления сервером;
ADMIN_PASSWORD — хеш пароля пользователя.

Пример файла инвентаря:

```yaml
install:
  hosts:
    host.example.org:
  vars:
    ansible_user: root
    ansible_password: PASSWORD
```

В случае указания `ansible_password` может возникнуть ошибка, если сервер не добавлен в `known_hosts`. Это происходит в целях безопасности, чтобы пароль не утёк на сторонний сервер. Для решения этой проблемы необходимо заранее подключиться к серверу и принять ключ (пароль вводить не обязательно, достаточно принять ключ), либо добавить переменную окружения для игнорирования ошибки:

```bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i INVENTORY install.yaml
```

Также можно не указывать пароль в файле инвентаризации, а запросить его в ходе подключения к серверу:

```bash
 ansible-playbook -i INVENTORY install.yaml --ask-pass
```

Установка переменных, например, групповых или для конкретной машины, может обеспечить запуск установки некоторых других настроек.

### Указать локаль

Можно подключить необходимую локаль. Для неё будет выполнена операция locale-gen и установка в качестве локали по умолчанию.

```yaml
locale: ru_RU.UTF-8
```

### Установка часового пояса

При необходимости можно установить часовой пояс:

```yaml
locale: ru_RU.UTF-8
```