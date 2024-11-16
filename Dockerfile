# Utiliser une image Python légère
FROM python:3.9-slim

# Installer les dépendances nécessaires pour Selenium
RUN apt-get update && apt-get install -y \
    python3-pip \
    chromium-driver \
    chromium-browser

# Copier les fichiers nécessaires dans l'image Docker
WORKDIR /app
COPY requierments.txt /app/requirements.txt

# Installer les dépendances Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copier le reste des fichiers
COPY . /app

# Exposer le port utilisé par Flask
EXPOSE 5000

# Lancer l'application Flask avec Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "mafra:app"]

