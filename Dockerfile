# Utiliser une image avec Python, Chrome et Node.js (pour Selenium)
FROM cypress/browsers:node16.18.0-chrome107-ff106

# Installer Python et les outils nécessaires
RUN apt-get update && apt-get install -y python3 python3-pip

# Copier les fichiers nécessaires
COPY requirements.txt /app/requirements.txt
WORKDIR /app

# Installer les dépendances Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copier les fichiers de l'application
COPY . /app

# Exposer le port (Render le gère via la variable $PORT)
EXPOSE 5000

# Lancer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "mafra:app"]
