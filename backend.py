import mysql.connector
from flask import Flask, render_template

app = Flask(__name__)

select_public_art_query = ("SELECT time, title, neighborhood, address, size, firstname, lastname, medium, description from public_art join location using (location_id) join size using (size_id) join public_art_has_artist using (public_art_id) join artist using (artist_id) join public_art_has_genre using (public_art_id) join genre using (genre_id)")

class Art_Database:
	def __init__(self):
		host = '127.0.0.1'
		user = 'root'
		password = 'jill0523'
		db = 'bosart'

		self.con = mysql.connector.connect(user=user, password=password,
					   host=host, database=db)

		self.cur = self.con.cursor()

	def list_paintings(self):
		self.cur.execute(select_public_art_query)
		result = self.cur.fetchall()

		return result

# cursor.close()
# cnx.close()

@app.route('/')
def paintings():

	def db_query():
		db = Art_Database()
		paintings = db.list_paintings()
		
		return paintings

	res = db_query()

	return render_template('index.html', result=res, content_type='application/json')

@app.route('/submit')
def submit():

	return render_template('submit.html')

@app.route('/about')
def about():

	return render_template('about.html')


if __name__ == "__main__":
	app.run()
