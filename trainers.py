from flask import *
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError
from sqlalchemy.sql import text
from models import TRAINER_SPEC, db , TRAINERS

trainers_blueprint=Blueprint('trainers',__name__)


@trainers_blueprint.route('/')
@trainers_blueprint.route('/<int:page_num>')
def trainer(page_num=1):

    count = db.engine.execute(f"SELECT count('T_ID') from 'TRAINERS'").scalar()
    
    Data_Paginate = TRAINERS.query.filter_by().paginate(per_page=5,page=page_num , error_out = False)
   
    return render_template('/adminstrap_theme/adminstrap_theme/trainers.html' , istrainers="active" , title = "Trainers" , rows = TRAINERS.query.all() , Data_Paginate=Data_Paginate , isact="active" , tcount=count , specs = TRAINER_SPEC.query.all())


@trainers_blueprint.route('/add_trainer' , methods=['POST'])
def add_trainer():
   Data_Paginate = TRAINERS.query.filter_by().paginate(per_page=5)

   if request.method == "POST":
       t_name = request.form.get("t_name")
       t_gender = request.form.get("t_gender")
       t_joindate = datetime.utcnow().date()
       t_email = request.form.get("t_email")
       t_mob_no = request.form.get("t_mob_no")
       t_location = request.form.get("t_location")
       
       try:
           trainer = db.engine.execute(f"INSERT INTO 'TRAINERS'('T_NAME' , 'T_GENDER' ,'T_JOINDATE' ,'T_EMAIL' ,'T_MOB_NO' , 'T_LOCATION') VALUES( '{t_name}' ,'{t_gender}' ,'{t_joindate}' ,'{t_email}' , '{t_mob_no}' , '{t_location}' ) ")
       except  Exception as e:
           print(e)
           db.session.rollback()
           flash("Trainer / email / mobile number already exists" , "danger" )
           return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))
           
       #trainer = TRAINERS(t_name , t_gender , t_joindate , t_email , t_mob_no , t_location)
       #db.session.add(trainer)
       #db.session.execute('pragma foreign_keys=on')
       #db.session.commit()    
   flash("Trainer added successfully" , "success")
   return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))

@trainers_blueprint.route('/add_spec' , methods=['POST'])
def add_spec():
    Data_Paginate = TRAINERS.query.filter_by().paginate(per_page=5)
    if request.method == "POST":
        t_id = request.form.get("t_id")
        t_spec = request.form.get("t_spec")
        print(t_id)
    
    try:
        trainer_spec = db.engine.execute(f"INSERT INTO 'TRAINER_SPEC'('T_SPEC' , 'TR_ID' ) VALUES( '{t_spec}' ,'{t_id}' ) ")
    except  Exception as e:
        print(e)
        db.session.rollback()
        flash("Trainer / Specialization already exists" , "danger" )
        return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))
            
    flash("Trainer specialization added successfully" , "success")
    return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))


@trainers_blueprint.route('/view_trainer')
def view_trainer():
    return "view_trainer"


@trainers_blueprint.route('/edit_trainer/<int:t_id>' ,methods=["POST"])
def edit_trainer(t_id):
    Data_Paginate = TRAINERS.query.filter_by().paginate(per_page=5)

    if request.method == "POST":
        t_name = request.form.get("t_name")
        t_gender = request.form.get("t_gender")
        t_email = request.form.get("t_email")
        t_mob_no = request.form.get("t_mob_no")
        t_location = request.form.get("t_location")
        print(t_email)
        try:
            db.engine.execute(f"Update  'TRAINERS' SET T_NAME='{t_name}' , T_GENDER= '{t_gender}'  , T_EMAIL='{t_email}' ,T_MOB_NO=  '{t_mob_no}'  , T_LOCATION='{t_location}' where T_ID ='{t_id}' ")
            flash("Trainer updated successfully" , "success")
        except  Exception as e:
            print(e)
            db.session.rollback()
            flash("Some error occured" , "danger" )
            return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))
               
   
    return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))

@trainers_blueprint.route('/delete_trainer/<int:t_id>' )
def delete_trainer(t_id):
    Data_Paginate = TRAINERS.query.filter_by().paginate(per_page=5)
    try:
        print(t_id)
        fk_check = db.session.execute("pragma foreign_keys=on");
        db.session.execute(f"DELETE FROM TRAINERS WHERE 'TRAINERS'.'T_ID' = {t_id}")
        db.session.commit()
    except  Exception as e:
        print(e)
        db.session.rollback()
        flash("Some error occured" , "danger" )
        return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))
       
    #my_data = TRAINERS.query.get(t_id)
    #db.session.delete(my_data)
    #db.session.commit()
    flash("Trainer deleted successfully" , "danger")
    return redirect(url_for('trainers.trainer',page_num=Data_Paginate.pages))