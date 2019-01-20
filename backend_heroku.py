import mysql.connector
import datetime
from flask import Flask, render_template, request

# Name of Flask application 'app'
app = Flask(__name__)

# Queries that will display information in part 1
select_public_art_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id)")
select_small_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where size like '%small%'")
select_medium_query =("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where size like '%medium%';")
select_large_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where size like '%large%';")
select_extralarge_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where size like '%extra large%';")
select_memorial_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%memorial%';")
select_sculpture_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%sculpture%';")
select_graffiti_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%graffiti%';")
select_statue_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%statue%';")
select_mural_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%mural%';")
select_vehicle_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%vehicle%';")
select_historic_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%historic site%';")
select_sign_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%sign%';")
select_bench_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%bench%';")
select_kinetic_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%kinetic%';")
select_plaque_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where medium like '%plaque%';")
select_beaconhill_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Beacon Hill%';")
select_southboston_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%South Boston%';")
select_backbay_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Back Bay%';")
select_cambridge_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Cambridge%';")
select_saugus_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Saugus%';")
select_southend_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%South End%';")
select_boston_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Boston%';")
select_fenway_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Fenway%';")
select_dorchester_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Dorchester%';")
select_jamaicaplain_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Jamaica Plain%';")
select_charlestown_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id)left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Charlestown%';")
select_eastboston_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%East Boston%';")
select_roxbury_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Roxbury%';")
select_eastcambridge_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%East Cambridge%';")
select_downtown_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Downtown%';")
select_bunkerhill_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Bunker Hill%';")
select_chinatown_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Chinatown%';")
select_somerville_query = ("SELECT extract(year from time), title, neighborhood, address, size, firstname, lastname, medium, description, image from public_art left join location using (location_id) left join size using (size_id) left join public_art_has_artist using (public_art_id) left join artist using (artist_id) left join public_art_has_genre using (public_art_id) left join genre using (genre_id) where neighborhood like '%Somerville%';")

# Setting up the connection
# to the database here
class Art_Database:
	def __init__(self):
		host = 'us-cdbr-iron-east-01.cleardb.net'
		user = 'b8f02d8fa9d3a2'
		password = 'b22681b9'
		db = 'heroku_b61b7dbaa58f0e4'

		self.con = mysql.connector.connect(user=user, host=host, password=password, database=db)
		self.cur = self.con.cursor()

	# Function to retrieve a certain size_id,
	# artist_id, genre_id or location_id, if it exists
	def get_size_artist_genre_location(self, input1, input2, input3):

		# Are we looking for a size?
		if (input1 == 'size'):
			arg1 = 'size_id'
			arg2 = 'size'
			arg3 = 'size'
			arg4 = input2

		# Are we looking for an artist?
		elif (input1 == 'artist'):
			arg1 = 'artist_id'
			arg2 = 'artist'
			arg3 = 'firstname'
			arg4 = input2
			arg5 = 'lastname'
			arg6 = input3

		# Are we looking for a genre?
		elif (input1 == 'genre'):
			arg1 = 'genre_id'
			arg2 = 'genre'
			arg3 = 'medium'
			arg4 = input2

		# Are we looking for a location?
		else:
			arg1 = 'location_id'
			arg2 = 'location'
			arg3 = 'neighborhood'
			arg4 = input2

		# Formulate the statement
		# Note: query is slightly different if we
		# are looking for an artist
		if (input1 == 'artist'):
			query = 'SELECT ' + arg1 + " from " + arg2 + " where " + arg3 + " like '%"  + arg4 + "%' and " + arg5 + " like '%" + arg6 + "%' limit 1;"

		else:
			query = 'SELECT ' + arg1 + " from " + arg2 + " where " + arg3 + " like '%" + arg4 + "%' limit 1;"

		# Execute the query
		self.cur.execute(query)
		result = self.cur.fetchall()

		return result

	# Function to get public_id from public_art table
	def get_public_art_id(self):

		# Query to get newest public_id
		query = "SELECT public_art_id from public_art ORDER BY public_art_id desc limit 1;"

		# Execute the query
		self.cur.execute(query)
		result = self.cur.fetchall()

		return result

	# Function to insert into public_art table
	def insert_public_art(self, year, desc, location, size, title, url):

		query = "INSERT into public_art (existence, time, description, location_id, size_id, title, image) values (1, %s, %s, %s, %s, %s, %s)"
		val = (datetime.datetime(int(year), 1, 1, 0, 0), desc, location, size, title, url)

		# Execute query
		self.cur.execute(query, val)
		self.con.commit()

	# Function to insert into join tables
	def insert_join_tbl(self, table, id_1, id_2):

		# Inserting into 'public_art_has_genre'?
		if (table == 'genre'):
			query = "INSERT into public_art_has_genre (public_art_id, genre_id) values (%s, %s)"

		# Inserting into 'public_art_has_artist' table
		else:
			query = "INSERT into public_art_has_artist (public_art_id, artist_id) values (%s, %s)"

		# Set values
		val = (id_1, id_2)

		# Execute query
		self.cur.execute(query, val)
		self.con.commit()

	# Function to insert new row in tables
	# 'location', 'genre' and 'artist'
	def insert_new_data(self, table, input1, input2):

		# Which table are we inserting into: location?
		if (table == 'location'):

			query = "INSERT into location (neighborhood, address) values (%s, %s)"
			val = (input1, input2)

		# Inerting into genre?
		elif (table == 'genre'):

			query = "INSERT into genre (medium) values (%s)"
			val = (input1,)

		# Inserting into artist?
		else:

			query = "INSERT into artist (firstname, lastname) values (%s, %s)"
			val = (input1, input2)

		# Execute query
		self.cur.execute(query, val)
		self.con.commit()

	# Function to list all public art
	def list_paintings(self):
		self.cur.execute(select_public_art_query)
		result = self.cur.fetchall()

		return result

	# Function to list all small art
	def filter_paintings(self, type):

		if (type == 'small'):

			self.cur.execute(select_small_query)
			result = self.cur.fetchall()

		elif (type == 'medium'):

			self.cur.execute(select_medium_query)
			result = self.cur.fetchall()

		elif (type == 'large'):

			self.cur.execute(select_large_query)
			result = self.cur.fetchall()

		elif (type == 'extralarge'):

			self.cur.execute(select_extralarge_query)
			result = self.cur.fetchall()

		elif (type == 'memorial'):

			self.cur.execute(select_memorial_query)
			result = self.cur.fetchall()

		elif (type == 'sculpture'):

			self.cur.execute(select_sculpture_query)
			result = self.cur.fetchall()

		elif (type == 'graffiti'):

			self.cur.execute(select_graffiti_query)
			result = self.cur.fetchall()

		elif (type == 'statue'):

			self.cur.execute(select_statue_query)
			result = self.cur.fetchall()

		elif (type == 'mural'):

			self.cur.execute(select_mural_query)
			result = self.cur.fetchall()

		elif (type == 'vehicle'):

			self.cur.execute(select_vehicle_query)
			result = self.cur.fetchall()

		elif (type == 'historicsite'):

			self.cur.execute(select_historic_query)
			result = self.cur.fetchall()

		elif (type == 'sign'):

			self.cur.execute(select_sign_query)
			result = self.cur.fetchall()

		elif (type == 'bench'):

			self.cur.execute(select_bench_query)
			result = self.cur.fetchall()

		elif (type == "kineticart"):

			self.cur.execute(select_kinetic_query)
			result = self.cur.fetchall()

		elif (type == "plaque"):

			self.cur.execute(select_plaque_query)
			result = self.cur.fetchall()

		elif (type == "beaconhill"):

			self.cur.execute(select_beaconhill_query)
			result = self.cur.fetchall()

		elif (type == "southboston"):

			self.cur.execute(select_southboston_query)
			result = self.cur.fetchall()

		elif (type == "backbay"):

			self.cur.execute(select_backbay_query)
			result = self.cur.fetchall()

		elif (type == "cambridge"):

			self.cur.execute(select_cambridge_query)
			result = self.cur.fetchall()

		elif (type == "saugus"):

			self.cur.execute(select_saugus_query)
			result = self.cur.fetchall()

		elif (type == "southend"):

			self.cur.execute(select_southend_query)
			result = self.cur.fetchall()

		elif (type == "boston"):

			self.cur.execute(select_boston_query)
			result = self.cur.fetchall()

		elif (type == "fenway"):

			self.cur.execute(select_fenway_query)
			result = self.cur.fetchall()

		elif (type == "dorchester"):

			self.cur.execute(select_dorchester_query)
			result = self.cur.fetchall()

		elif (type == "jamaicaplain"):

			self.cur.execute(select_jamaicaplain_query)
			result = self.cur.fetchall()

		elif (type == "charlestown"):

			self.cur.execute(select_charlestown_query)
			result = self.cur.fetchall()

		elif (type == "eastboston"):

			self.cur.execute(select_eastboston_query)
			result = self.cur.fetchall()

		elif (type == "roxbury"):

			self.cur.execute(select_roxbury_query)
			result = self.cur.fetchall()

		elif (type == "eastcambridge"):

			self.cur.execute(select_eastcambridge_query)
			result = self.cur.fetchall()

		elif (type == "downtown"):

			self.cur.execute(select_downtown_query)
			result = self.cur.fetchall()

		elif (type == "bunkerhill"):

			self.cur.execute(select_bunkerhill_query)
			result = self.cur.fetchall()

		elif (type == "chinatown"):

			self.cur.execute(select_chinatown_query)
			result = self.cur.fetchall()

		elif (type == "somerville"):

			self.cur.execute(select_somerville_query)
			result = self.cur.fetchall()

		return result

# Filtering
@app.route('/filter', methods=['GET', 'POST'])
def filter():

	# Connect to the database
	def init_db_connect():

		db = Art_Database()

		return db

	# Retrieve information from database query
	def db_query(string, db):

		paintings = db.filter_paintings(string)

		return paintings

	# Connect to the Art_Database
	db = init_db_connect()

	# Get value
	query = request.form['filter']

	res = db_query(query, db)

	# Render the index
	return render_template('index.html', result=res, content_type='application/json')

# Index page
@app.route('/', methods=['GET', 'POST'])
def paintings():

	# Connect to the database
	def init_db_connect():

		db = Art_Database()

		return db

	# Retrieve information from database query
	def db_query():

		paintings = db.list_paintings()

		return paintings

	# Connect to the Art_Database
	db = init_db_connect()

	# Initial query
	res = db_query()

	# Render the index
	return render_template('index.html', result=res, content_type='application/json')

# Inserting data to art database
@app.route('/insert', methods=['GET', 'POST'])
def insert():
	# Connect to the database
	def init_db_connect():

		db = Art_Database()

		return db

	# Connect to the database
	db = init_db_connect()

	# PROCESS: GENERATING FIRST TABLES
	# Use select query to get size_id of given size
	size_id = db.get_size_artist_genre_location('size', request.form['size'], '')[0][0]

	# Use select query to get location_id, using neighborhood
	location_id = db.get_size_artist_genre_location('location', request.form['neighborhood'], '')

	# No matching location already in database?
	if not location_id:

		# If no match, create a new location and then query to get that location_id
		db.insert_new_data('location', request.form['neighborhood'], request.form['location'])

		location_id = db.get_size_artist_genre_location('location', request.form['neighborhood'], '')[0][0]

	else:
		location_id = location_id[0][0]

	# Use select query to get genre_id of given genre
	genre_id = db.get_size_artist_genre_location('genre', request.form['genre'], '')

	# Matching genre already in database?
	if not genre_id:

		# If a matching genre exists, use that genre_id
		db.insert_new_data('genre', request.form['genre'], '')
		genre_id = db.get_size_artist_genre_location('genre', request.form['genre'], '')[0][0]

	else:
		genre_id = genre_id[0][0]

	# Use select query to get artist_id of given artist
	artist_id = db.get_size_artist_genre_location('artist', request.form['artistfirst'], request.form['artistlast'])

	if not artist_id:

		db.insert_new_data('artist', request.form['artistfirst'], request.form['artistlast'])
		artist_id = db.get_size_artist_genre_location('artist', request.form['artistfirst'], request.form['artistlast'])[0][0]

	else:
		artist_id = artist_id[0][0]

	# Public art table: Insert using the stored size_id, location_id and genre_id
	db.insert_public_art(request.form['date'], request.form['description'], location_id, size_id, request.form['title'], request.form['image'])

	# PROCESS: GENERATING FINAL TABLES
	# Query to get public_art_id of final table
	public_art_id = db.get_public_art_id()[0][0]

	# Insert into public_art_has_artist with public_art_id, artist_id
	db.insert_join_tbl('artist', public_art_id, artist_id)

	# Insert into public_art_has_genre with public_art_id, genre_id
	db.insert_join_tbl('genre', public_art_id, genre_id)

	submission_successful = True

	return render_template('index.html', submission_successful=submission_successful)

# Submit page
@app.route('/submit')
def submit():

	return render_template('submit.html')

# About page
@app.route('/about')
def about():

	return render_template('about.html')


if __name__ == "__main__":
	app.run()
