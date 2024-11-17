from flask import Flask, request, jsonify
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

app = Flask(__name__)

def download_selenium():
    try:
        # Configurer les options Chrome
        chrome_options = Options()
        chrome_options.add_argument('--headless')  # Exécution sans interface graphique
        chrome_options.add_argument('--no-sandbox')  # Nécessaire pour les environnements Docker
        chrome_options.add_argument('--disable-dev-shm-usage')

        # Créer une instance de WebDriver
        driver = webdriver.Chrome(options=chrome_options)

        # Charger la page Google
        driver.get("https://www.google.com/")

        # Récupérer le titre de la page
        title = driver.title
        driver.quit()

        # Retourner le titre dans un dictionnaire
        return jsonify({'Page titre io': title})

    except Exception as e:
        # Capturer et retourner l'erreur
        return jsonify({'error': str(e)}), 500


@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'GET':
        return download_selenium()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
