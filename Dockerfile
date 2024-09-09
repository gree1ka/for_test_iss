# Используем официальный образ Python 3.11
FROM python:3.11-slim

# Установка зависимостей для PostgreSQL
RUN apt-get update && apt-get install -y libpq-dev gcc
RUN apt-get update && apt-get install -y postgresql-client

# Установка рабочей директории
WORKDIR /app/testissue

# Копируем все файлы проекта в рабочую директорию
COPY testissue/ /app/testissue/
COPY wait-for-db.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Открываем порт для Django (по умолчанию 8000)
EXPOSE 8000

# Запускаем команду для запуска сервера Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
