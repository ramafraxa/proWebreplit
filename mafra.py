from flask import Flask, request, jsonify
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

app = Flask(__name__)

def download_selenium():
    try:
        # Configurer les options Chrome
        chrome_options = Options()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')

        # Installer et configurer le service pour ChromeDriver
        driver = webdriver.Chrome( service=Service(ChromeDriverManager(version="130.0.6723.116").install()),options=chrome_options)


        
        # Charger la page Google
        driver.get("https://www.google.com/")
        
        # Récupérer le titre de la page
        title = driver.title
        driver.quit()

        # Retourner le titre dans un dictionnaire
        return jsonify({'Page title': title})

    except Exception as e:
        # Capturer et retourner l'erreur
        return jsonify({'error': str(e)}), 500


@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'GET':
        return download_selenium()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
