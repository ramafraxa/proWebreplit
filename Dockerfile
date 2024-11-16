FROM python:3.9-slim

# Installer les dépendances pour Selenium et ChromeDriver
RUN apt-get update && apt-get install -y \
    chromium-driver \
    chromium-browser \
    python3-pip

# Copier les fichiers nécessaires
COPY requirements.txt /app/requirements.txt
WORKDIR /app

# Installer les dépendances Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copier les fichiers de l'application
COPY . /app

# Exposer le port
EXPOSE 5000

# Lancer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "mafra:app"]
