# ASKME

Приложение предназначено для того, чтобы задавать пользователям вопросы и получать на них ответы.

![image](https://user-images.githubusercontent.com/70809854/194772693-ac268221-5b34-41e5-b997-3a0e91e65476.png)

## В разработке использованы

Rails 7.0.1

Ruby 3.0.2

Gravtastic - модуль [Gravatar API](https://ru.gravatar.com/) для использования в Rails-приложениях

Google reCAPTCHA v2 - модуль для валидации HTML форм, отправляемых реальными клиентами (Антибот)

## Установка

1. Загрузить исходники проекта

2. Установить гемы проека и установить базу данных 
```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
```
3. Установить в переменных среды (.env или настройки Heroku):
```
RECAPTCHA_ASKME_PUBLIC_KEY=<публичный ключ капчи>
RECAPTCHA_ASKME_PRIVATE_KEY=<секретный ключ капчи>
```

4. Запустить локальный сервер 
```
bundle exec rails s
```
В production-окружении приложение настроено на работу с Heroku.
