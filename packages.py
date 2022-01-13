from flask import Blueprint,render_template
from flask import *
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError
from sqlalchemy.sql import text
from models import *

packages_blueprint=Blueprint('packages',__name__)


@packages_blueprint.route('/')
@packages_blueprint.route('/<int:page_num>')
def package(page_num=1):
    count = db.engine.execute(f"SELECT count('P_ID') from 'PACKAGE'").scalar()
    
    Data_Paginate = PACKAGE.query.filter_by().paginate(per_page=5,page=page_num , error_out = False)
   
    return render_template('/adminstrap_theme/adminstrap_theme/packages.html' , ispackages="active" , title = "Packages" , rows = PACKAGE.query.all() , Data_Paginate=Data_Paginate , isact="active" , pcount=count )


@packages_blueprint.route('/add_package' , methods=['POST'])
def add_package():
   Data_Paginate = PACKAGE.query.filter_by().paginate(per_page=5)

   if request.method == "POST":
       p_name = request.form.get("p_name")
       p_price = request.form.get("p_price")
       p_duration = request.form.get("p_duration")

       
       try:
           package = db.engine.execute(f"INSERT INTO 'PACKAGE'('P_NAME' , 'P_PRICE' ,'P_DURATION') VALUES( '{p_name}' ,'{p_price}' ,'{p_duration}' ) ")
       except  Exception as e:
           print(e)
           db.session.rollback()
           flash("Package already exists" , "danger" )
           return redirect(url_for('packages.package',page_num=Data_Paginate.pages))
             
   flash("Package added successfully" , "success")
   return redirect(url_for('packages.package',page_num=Data_Paginate.pages))


@packages_blueprint.route('/edit_package/<int:p_id>' , methods=['POST'])
def edit_package(p_id):
   Data_Paginate = PACKAGE.query.filter_by().paginate(per_page=5)

   if request.method == "POST":
       p_name = request.form.get("p_name")
       p_price = request.form.get("p_price")
       p_duration = request.form.get("p_duration")

       try:
           package = db.engine.execute(f"Update  'PACKAGE' SET P_NAME='{p_name}' , P_PRICE= '{p_price}'  , P_DURATION='{p_duration}'  where P_ID ='{p_id}'")
       except  Exception as e:
           print(e)
           db.session.rollback()
           flash("Some error occured" , "danger" )
           return redirect(url_for('packages.package',page_num=Data_Paginate.pages))
             
   flash("Package updated successfully" , "success")
   return redirect(url_for('packages.package',page_num=Data_Paginate.pages))

@packages_blueprint.route('/delete_package/<int:p_id>' )
def delete_package(p_id):
    Data_Paginate = PACKAGE.query.filter_by().paginate(per_page=5)
    try:
        print(p_id)
        fk_check = db.session.execute("pragma foreign_keys=on");
        db.session.execute(f"DELETE FROM PACKAGE WHERE 'PACKAGE'.'P_ID' = {p_id}")
        db.session.commit()
    except  Exception as e:
        print(e)
        db.session.rollback()
        flash("Some error occured" , "danger" )
        return redirect(url_for('packages.package',page_num=Data_Paginate.pages))
       
    flash("Package deleted successfully" , "danger")
    return redirect(url_for('packages.package',page_num=Data_Paginate.pages))