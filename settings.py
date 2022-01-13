from flask import Flask
from flask.helpers import url_for

from datetime import timedelta



##################################--FLASK-SETUP--#########################################

app=Flask(__name__)

#import blueprints
from trainers import trainers_blueprint
from members import members_blueprint
from packages import packages_blueprint
from equipments import equipments_blueprint
from exercises import exercises_blueprint

#register blueprints
app.register_blueprint(trainers_blueprint , url_prefix = '/trainers')
app.register_blueprint(members_blueprint , url_prefix = '/members')
app.register_blueprint(packages_blueprint , url_prefix = '/packages')
app.register_blueprint(equipments_blueprint , url_prefix = '/equipments')
app.register_blueprint(exercises_blueprint , url_prefix = '/exercises')

app.config['SQLALCHEMY_DATABASE_URI']='sqlite:///gymdb.db'
#app.config['SQLALCHEMY_DATABASE_URI']= 'mysql://root:Mysql123@localhost/gymdb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

app.secret_key="abc"
