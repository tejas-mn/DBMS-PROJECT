from flask import Flask, render_template, flash, redirect, url_for, session, request, logging, make_response,jsonify

from settings import app

@app.route('/')
def index():
    return render_template('/adminstrap_theme/adminstrap_theme/index.html', title="Dashboard" , isactive="active")

@app.route('/base')
def dashboard():
    return render_template('base.html' , title="base template" , isactive="active")

if __name__ == "__main__":
    app.run(debug=True)