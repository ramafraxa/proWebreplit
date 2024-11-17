# Utiliser une image Selenium avec Chrome préconfiguré
FROM selenium/standalone-chrome:114.0

# Installer les dépendances Python nécessaires
USER root
RUN apt-get update && apt-get install -y \
    python3-pip \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier requirements.txt et installer les dépendances Python
COPY requierments.txt /app/requierments.txt
RUN pip3 install --no-cache-dir -r /app/requierments.txt

# Copier le reste des fichiers du projet
COPY . /app

# Exposer le port utilisé par Flask
EXPOSE 5000

# Lancer l'application Flask avec Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "mafra:app"]
