   # 1. Указываем базовый образ
   FROM python:3.12.3

   # 2. Обновляем пакеты и устанавливаем необходимые системные зависимости
   RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         && rm -rf /var/lib/apt/lists/*

   # 3. Устанавливаем рабочую директорию внутри контейнера
   WORKDIR /app

   # 4. Копируем файл с зависимостями (если он есть)
   COPY requirements.txt .

   # 5. Обновляем pip и устанавливаем зависимости из requirements.txt
   RUN pip install --upgrade pip && pip install -r requirements.txt

   # 6. Устанавливаем Jupyter Notebook (если он не указан в requirements.txt)
   RUN pip install jupyter

   # 7. Открываем порт 8888 для доступа к Jupyter Notebook
   EXPOSE 8888

   # 8. Определяем команду, которая будет выполнена при запуске контейнера
   CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]